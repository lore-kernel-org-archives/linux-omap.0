From: Felipe Balbi <me@felipebalbi.com>
Subject: [patch] kill compile warning on twl4030-power.c
Date: Mon, 15 Sep 2008 18:12:11 +0300
Message-ID: <20080915151208.GA17076@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56416 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYIOPM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 11:12:29 -0400
Received: from a91-154-126-225.elisa-laajakaista.fi ([91.154.126.225]:26491 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1KfFkW-0000Pk-Hn
	for linux-omap@vger.kernel.org; Mon, 15 Sep 2008 10:12:26 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

From: Felipe Balbi <felipe.balbi@nokia.com>

This part of the patch was left out on previous merge. Here's a
fix for that.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
index 04a13aa..afc19cd 100644
--- a/drivers/i2c/chips/twl4030-power.c
+++ b/drivers/i2c/chips/twl4030-power.c
@@ -215,7 +215,6 @@ static int __init twl4030_write_script(u8 address, struct triton_ins *script,
 static int __init config_sleep_wake_sequence(void)
 {
        int err = 0;
-       u8 data;
 
        /*
         * CLKREQ is pulled high on the 2430SDP, therefore, we need to take

-- 
balbi
