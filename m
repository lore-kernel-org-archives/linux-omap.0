From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [FYI PATCH] ASOC:TWL4030 Audio capture fix
Date: Fri, 5 Dec 2008 16:46:34 -0800
Message-ID: <5e088bd90812051646ga198c54m54b5d856618b6c1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:56225 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbYLFAqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 19:46:35 -0500
Received: by wf-out-1314.google.com with SMTP id 27so241262wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 16:46:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

A couple of folks have noticed an issue with audio capture -- the
capture result is always silence.

The patch below is a quick fix for those with this issue.  There are
substantial changes to the codec driver that will be trickling down
from ASoC, and they deal with this issue differently.

So consider this as a bandaid for those who don't want to wait for the
trickle down :-)

Steve


diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ee2f0d3..8b4aafb 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -45,8 +45,8 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0xc3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
-	0x24, /* REG_ANAMICL		(0x5)	*/
-	0x04, /* REG_ANAMICR		(0x6)	*/
+	0x34, /* REG_ANAMICL		(0x5)	*/
+	0x14, /* REG_ANAMICR		(0x6)	*/
 	0x0a, /* REG_AVADC_CTL		(0x7)	*/
 	0x00, /* REG_ADCMICSEL		(0x8)	*/
 	0x00, /* REG_DIGMIXING		(0x9)	*/
