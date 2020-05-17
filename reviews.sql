-- table reviews
-- count 8

-- kalo udah ada triggernya, review_id nanti di apus
create sequence review_seq 
minvalue 1   
maxvalue 9999   
start with 1   
increment by 1   
cache 20

CREATE OR REPLACE TRIGGER next_review_trigger  
BEFORE INSERT ON    Reviews
FOR EACH ROW  
BEGIN  
    IF :new.review_id IS NULL THEN  
        :new.review_id := ('REV' || TO_CHAR(review_seq.nextval, 'FM0000'));  
    END IF;  
END;  


-- reviewnya masih dummy ntar ganti
-- reviewnya udah sesuai invoice
insert into reviews values ('ST030', 'NULL', 'C0371', '4', 'lorem ipsum', timestamp '2020-03-25 05:11:27');
insert into reviews values ('ST086', 'NULL', 'C0294', '4', 'lorem ipsum', timestamp '2020-04-18 10:03:32');
insert into reviews values ('ST080', 'NULL', 'C0191', '4', 'lorem ipsum', timestamp '2020-03-11 20:15:52');
insert into reviews values ('ST012', 'NULL', 'C0203', '5', 'lorem ipsum', timestamp '2020-05-12 00:01:24');
insert into reviews values ('ST089', 'NULL', 'C0202', '5', 'lorem ipsum', timestamp '2020-05-16 05:20:37');
insert into reviews values ('ST009', 'REV0006', 'C0233', '5', 'lorem ipsum', timestamp '2020-03-06 06:55:24');
insert into reviews values ('ST026', 'REV0007', 'C0078', '3', 'lorem ipsum', timestamp '2020-05-16 17:54:57');
insert into reviews values ('ST032', 'REV0008', 'C0093', '5', 'lorem ipsum', timestamp '2020-05-04 13:49:38');
insert into reviews values ('ST025', 'REV0009', 'C0020', '5', 'lorem ipsum', timestamp '2020-05-06 21:17:07');
insert into reviews values ('ST062', 'REV0010', 'C0196', '4', 'lorem ipsum', timestamp '2020-03-27 04:08:48');
insert into reviews values ('ST043', 'REV0011', 'C0020', '4', 'lorem ipsum', timestamp '2020-04-13 14:58:46');
insert into reviews values ('ST079', 'REV0012', 'C0170', '4', 'lorem ipsum', timestamp '2020-04-12 04:48:33');
insert into reviews values ('ST084', 'REV0013', 'C0036', '4', 'lorem ipsum', timestamp '2020-03-19 03:24:00');
insert into reviews values ('ST032', 'REV0014', 'C0231', '5', 'lorem ipsum', timestamp '2020-02-26 00:47:57');
insert into reviews values ('ST080', 'REV0015', 'C0311', '5', 'lorem ipsum', timestamp '2020-04-14 15:01:42');
insert into reviews values ('ST099', 'REV0016', 'C0110', '1', 'lorem ipsum', timestamp '2020-05-11 12:31:03');
insert into reviews values ('ST003', 'REV0017', 'C0308', '5', 'lorem ipsum', timestamp '2020-04-14 08:10:00');
insert into reviews values ('ST032', 'REV0018', 'C0269', '4', 'lorem ipsum', timestamp '2020-04-12 06:10:18');
insert into reviews values ('ST090', 'REV0019', 'C0006', '3', 'lorem ipsum', timestamp '2020-02-01 16:52:52');
insert into reviews values ('ST070', 'REV0020', 'C0044', '4', 'lorem ipsum', timestamp '2020-05-20 02:29:33');
insert into reviews values ('ST022', 'REV0021', 'C0097', '2', 'lorem ipsum', timestamp '2020-03-09 16:17:36');
insert into reviews values ('ST095', 'REV0022', 'C0330', '5', 'lorem ipsum', timestamp '2020-04-30 18:15:02');
insert into reviews values ('ST072', 'REV0023', 'C0269', '2', 'lorem ipsum', timestamp '2020-04-30 20:13:42');
insert into reviews values ('ST075', 'REV0024', 'C0121', '3', 'lorem ipsum', timestamp '2020-01-31 13:18:59');
insert into reviews values ('ST091', 'REV0025', 'C0136', '5', 'lorem ipsum', timestamp '2020-05-23 12:52:04');
insert into reviews values ('ST042', 'REV0026', 'C0152', '5', 'lorem ipsum', timestamp '2020-05-11 10:26:08');
insert into reviews values ('ST050', 'REV0027', 'C0303', '5', 'lorem ipsum', timestamp '2020-05-13 01:58:32');
insert into reviews values ('ST068', 'REV0028', 'C0026', '3', 'lorem ipsum', timestamp '2020-05-01 18:36:13');
insert into reviews values ('ST043', 'REV0029', 'C0370', '5', 'lorem ipsum', timestamp '2020-04-30 09:36:24');
insert into reviews values ('ST003', 'REV0030', 'C0284', '5', 'lorem ipsum', timestamp '2020-03-01 20:50:16');
insert into reviews values ('ST058', 'REV0031', 'C0342', '4', 'lorem ipsum', timestamp '2020-04-16 04:05:00');
insert into reviews values ('ST068', 'REV0032', 'C0150', '2', 'lorem ipsum', timestamp '2020-01-25 02:08:14');
insert into reviews values ('ST032', 'REV0033', 'C0270', '3', 'lorem ipsum', timestamp '2020-03-09 15:13:35');
insert into reviews values ('ST059', 'REV0034', 'C0210', '4', 'lorem ipsum', timestamp '2020-05-20 00:36:35');
insert into reviews values ('ST022', 'REV0035', 'C0256', '3', 'lorem ipsum', timestamp '2020-05-06 11:11:06');
insert into reviews values ('ST074', 'REV0036', 'C0081', '5', 'lorem ipsum', timestamp '2020-05-05 14:08:00');
insert into reviews values ('ST009', 'REV0037', 'C0162', '3', 'lorem ipsum', timestamp '2020-05-08 22:08:32');
insert into reviews values ('ST008', 'REV0038', 'C0095', '2', 'lorem ipsum', timestamp '2020-02-24 16:44:53');
insert into reviews values ('ST092', 'REV0039', 'C0233', '4', 'lorem ipsum', timestamp '2020-05-07 11:04:47');
insert into reviews values ('ST021', 'REV0040', 'C0191', '3', 'lorem ipsum', timestamp '2020-04-14 15:48:04');
insert into reviews values ('ST045', 'REV0041', 'C0389', '4', 'lorem ipsum', timestamp '2020-04-27 22:30:42');
insert into reviews values ('ST028', 'REV0042', 'C0008', '4', 'lorem ipsum', timestamp '2020-05-07 06:02:04');
insert into reviews values ('ST024', 'REV0043', 'C0323', '1', 'lorem ipsum', timestamp '2020-04-11 11:18:14');
insert into reviews values ('ST046', 'REV0044', 'C0241', '3', 'lorem ipsum', timestamp '2020-05-07 04:15:06');
insert into reviews values ('ST040', 'REV0045', 'C0287', '4', 'lorem ipsum', timestamp '2020-05-17 20:07:57');
insert into reviews values ('ST093', 'REV0046', 'C0045', '3', 'lorem ipsum', timestamp '2020-05-16 07:14:52');
insert into reviews values ('ST058', 'REV0047', 'C0048', '3', 'lorem ipsum', timestamp '2020-04-24 09:57:58');
insert into reviews values ('ST037', 'REV0048', 'C0192', '4', 'lorem ipsum', timestamp '2020-03-23 05:28:33');
insert into reviews values ('ST009', 'REV0049', 'C0178', '4', 'lorem ipsum', timestamp '2020-04-26 23:30:08');
insert into reviews values ('ST039', 'REV0050', 'C0233', '4', 'lorem ipsum', timestamp '2020-04-14 09:21:30');
insert into reviews values ('ST047', 'REV0051', 'C0033', '3', 'lorem ipsum', timestamp '2020-05-17 12:24:03');
insert into reviews values ('ST083', 'REV0052', 'C0007', '5', 'lorem ipsum', timestamp '2020-03-13 03:40:55');
insert into reviews values ('ST032', 'REV0053', 'C0343', '4', 'lorem ipsum', timestamp '2020-05-07 08:09:24');
insert into reviews values ('ST015', 'REV0054', 'C0139', '5', 'lorem ipsum', timestamp '2020-05-14 19:13:49');
insert into reviews values ('ST084', 'REV0055', 'C0399', '4', 'lorem ipsum', timestamp '2020-03-30 07:58:40');
insert into reviews values ('ST071', 'REV0056', 'C0321', '4', 'lorem ipsum', timestamp '2020-05-16 10:13:56');
insert into reviews values ('ST081', 'REV0057', 'C0209', '1', 'lorem ipsum', timestamp '2020-01-20 15:35:50');
insert into reviews values ('ST022', 'REV0058', 'C0134', '3', 'lorem ipsum', timestamp '2020-05-04 01:46:53');
insert into reviews values ('ST080', 'REV0059', 'C0262', '2', 'lorem ipsum', timestamp '2020-05-22 03:50:04');
insert into reviews values ('ST088', 'REV0060', 'C0333', '5', 'lorem ipsum', timestamp '2020-04-27 08:58:34');
insert into reviews values ('ST029', 'REV0061', 'C0279', '3', 'lorem ipsum', timestamp '2020-01-18 10:54:49');
insert into reviews values ('ST085', 'REV0062', 'C0324', '3', 'lorem ipsum', timestamp '2020-05-23 05:32:26');
insert into reviews values ('ST059', 'REV0063', 'C0007', '3', 'lorem ipsum', timestamp '2020-05-13 10:23:54');
insert into reviews values ('ST038', 'REV0064', 'C0101', '4', 'lorem ipsum', timestamp '2020-04-18 22:41:34');
insert into reviews values ('ST071', 'REV0065', 'C0284', '3', 'lorem ipsum', timestamp '2020-05-12 16:36:16');
insert into reviews values ('ST029', 'REV0066', 'C0040', '3', 'lorem ipsum', timestamp '2020-04-06 20:30:08');
insert into reviews values ('ST093', 'REV0067', 'C0336', '3', 'lorem ipsum', timestamp '2020-05-08 23:16:14');
insert into reviews values ('ST053', 'REV0068', 'C0236', '2', 'lorem ipsum', timestamp '2020-04-12 22:50:19');
insert into reviews values ('ST051', 'REV0069', 'C0080', '3', 'lorem ipsum', timestamp '2020-05-10 07:38:20');
insert into reviews values ('ST025', 'REV0070', 'C0208', '2', 'lorem ipsum', timestamp '2020-04-17 05:47:20');
insert into reviews values ('ST062', 'REV0071', 'C0166', '1', 'lorem ipsum', timestamp '2020-05-28 12:06:44');
insert into reviews values ('ST029', 'REV0072', 'C0229', '5', 'lorem ipsum', timestamp '2020-04-03 19:07:04');
insert into reviews values ('ST085', 'REV0073', 'C0238', '5', 'lorem ipsum', timestamp '2020-01-20 00:00:51');
insert into reviews values ('ST051', 'REV0074', 'C0064', '3', 'lorem ipsum', timestamp '2020-02-14 19:51:28');
insert into reviews values ('ST066', 'REV0075', 'C0319', '4', 'lorem ipsum', timestamp '2020-02-16 22:39:52');
insert into reviews values ('ST052', 'REV0076', 'C0108', '2', 'lorem ipsum', timestamp '2020-04-13 06:31:06');
insert into reviews values ('ST032', 'REV0077', 'C0205', '1', 'lorem ipsum', timestamp '2020-05-15 06:54:43');
insert into reviews values ('ST044', 'REV0078', 'C0068', '4', 'lorem ipsum', timestamp '2020-02-14 07:15:57');
insert into reviews values ('ST041', 'REV0079', 'C0169', '4', 'lorem ipsum', timestamp '2020-03-23 10:10:48');
insert into reviews values ('ST100', 'REV0080', 'C0131', '3', 'lorem ipsum', timestamp '2020-03-20 16:20:52');
insert into reviews values ('ST031', 'REV0081', 'C0154', '5', 'lorem ipsum', timestamp '2020-03-20 05:01:04');
insert into reviews values ('ST052', 'REV0082', 'C0192', '4', 'lorem ipsum', timestamp '2020-05-27 14:45:58');
insert into reviews values ('ST081', 'REV0083', 'C0070', '5', 'lorem ipsum', timestamp '2020-04-20 00:28:02');
insert into reviews values ('ST073', 'REV0084', 'C0085', '4', 'lorem ipsum', timestamp '2020-04-04 23:19:44');
insert into reviews values ('ST085', 'REV0085', 'C0122', '5', 'lorem ipsum', timestamp '2020-03-12 14:56:00');
insert into reviews values ('ST030', 'REV0086', 'C0298', '4', 'lorem ipsum', timestamp '2020-04-26 09:16:36');
insert into reviews values ('ST051', 'REV0087', 'C0194', '3', 'lorem ipsum', timestamp '2020-05-16 00:10:21');
insert into reviews values ('ST047', 'REV0088', 'C0333', '5', 'lorem ipsum', timestamp '2020-04-23 06:17:45');
insert into reviews values ('ST062', 'REV0089', 'C0361', '5', 'lorem ipsum', timestamp '2020-03-10 16:55:52');
insert into reviews values ('ST079', 'REV0090', 'C0188', '4', 'lorem ipsum', timestamp '2020-05-13 17:21:53');
insert into reviews values ('ST042', 'REV0091', 'C0205', '4', 'lorem ipsum', timestamp '2020-04-27 20:57:36');
insert into reviews values ('ST046', 'REV0092', 'C0130', '5', 'lorem ipsum', timestamp '2020-04-26 23:54:54');
insert into reviews values ('ST069', 'REV0093', 'C0018', '3', 'lorem ipsum', timestamp '2020-04-03 03:54:57');
insert into reviews values ('ST012', 'REV0094', 'C0067', '5', 'lorem ipsum', timestamp '2020-04-13 07:37:15');
insert into reviews values ('ST061', 'REV0095', 'C0134', '1', 'lorem ipsum', timestamp '2020-04-03 14:21:05');
insert into reviews values ('ST020', 'REV0096', 'C0333', '5', 'lorem ipsum', timestamp '2020-01-15 02:10:47');
insert into reviews values ('ST044', 'REV0097', 'C0249', '1', 'lorem ipsum', timestamp '2020-05-03 12:27:39');
insert into reviews values ('ST050', 'REV0098', 'C0352', '1', 'lorem ipsum', timestamp '2020-05-07 02:25:19');
insert into reviews values ('ST002', 'REV0099', 'C0172', '5', 'lorem ipsum', timestamp '2020-03-23 05:08:59');
insert into reviews values ('ST068', 'REV0100', 'C0204', '5', 'lorem ipsum', timestamp '2020-04-29 05:27:40');
insert into reviews values ('ST068', 'REV0101', 'C0040', '4', 'lorem ipsum', timestamp '2020-05-08 18:43:23');
insert into reviews values ('ST049', 'REV0102', 'C0169', '3', 'lorem ipsum', timestamp '2020-05-12 10:22:10');
