From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: V 3.0-rc1: [REPORT]  OMAP MMC and CONSOLE  Regression
Date: Mon, 30 May 2011 18:03:12 +0530
Message-ID: <4DE38E88.1030402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:48309 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756612Ab1E3MdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 08:33:18 -0400
Received: by gyg13 with SMTP id 13so1689315gyg.41
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 05:33:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>

While trying out V3.0-rc1, I noticed couple of regressions. Am
posting this in case anybody come across same issues.

1.OMAP MMC code keep throwing "Pbias Voltage is not same as LDO" error
continuously.

Balaji is planning post right fix for the same, but just
in case you get around this issue,

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b2f30be..94ae400 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -145,6 +145,7 @@ static void omap4_hsmmc1_after_set_reg(struct device 
*dev, int slot,
  				 int power_on, int vdd)
  {
  	u32 reg;
+	unsigned long timeout;

  	if (power_on) {
  		reg = omap4_ctrl_pad_readl(control_pbias_offset);
@@ -158,7 +159,14 @@ static void omap4_hsmmc1_after_set_reg(struct 
device *dev, int slot,
  			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
  		omap4_ctrl_pad_writel(reg, control_pbias_offset);
  		/* 4 microsec delay for comparator to generate an error*/
-		udelay(4);
+		timeout = jiffies + msecs_to_jiffies(500);
+		do {
+			reg = omap4_ctrl_pad_readl(control_pbias_offset);
+			if (!(reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK))
+				break;
+			mdelay(1);
+		} while (!time_after(jiffies, timeout));
+
  		reg = omap4_ctrl_pad_readl(control_pbias_offset);
  		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
  			pr_err("Pbias Voltage is not same as LDO\n");

2. can't open /dev/ttyO2: No such file or directory

This is not obvious console entry missing problem in FS.
Need to look at this further.



