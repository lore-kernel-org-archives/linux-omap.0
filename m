From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 1/1] twl4030-madc: Fix arbitrarily initialized function pointer
Date: Wed,  2 Jul 2008 16:36:36 +0300
Message-ID: <1215005796-10117-2-git-send-email-viktor.rosendahl@nokia.com>
References: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60187 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYGBN3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 09:29:55 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m62DSmtO013302
	for <linux-omap@vger.kernel.org>; Wed, 2 Jul 2008 08:29:51 -0500
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m62DTT1l006470
	for <linux-omap@vger.kernel.org>; Wed, 2 Jul 2008 16:29:31 +0300
In-Reply-To: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

req is an automatic variable and thus we cannot rely on it being initialized to
zero (I am leaving the 0!= NULL discussion aside). Other functions test
if this pointer is NULL, in order to determine whether it is a valid address or
not.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 drivers/i2c/chips/twl4030-madc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-madc.c b/drivers/i2c/chips/twl4030-madc.c
index 72b126b..743db74 100644
--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -367,6 +367,7 @@ static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
 		req.channels = (1<<par.channel);
 		req.do_avg	= par.average;
 		req.method	= TWL4030_MADC_SW1;
+		req.func_cb	= NULL;
 
 		val = twl4030_madc_conversion(&req);
 		if (val <= 0) {
-- 
1.5.5.3

