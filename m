From: Xiao Jiang <jgq516@gmail.com>
Subject: About set boot_on for clk32kg regulator
Date: Wed, 06 Jun 2012 18:55:06 +0800
Message-ID: <4FCF370A.6000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54500 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2FFKBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 06:01:52 -0400
Received: by vbbff1 with SMTP id ff1so3704292vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jun 2012 03:01:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: vishalm@ti.com, coelho@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

For panda and blaze, wl12xx sdio card can't be found without set on 
label in struct omap4_clk32kg_idata,
and after search maillist I found Vishal had posted patch for it.
http://marc.info/?l=linux-omap&m=132017988123957&w=2

But after more investigations, if clk32kg regulator isn't on then sdio 
bus can't probe
wl12xx sdio card, which means it isn't possible to enable regulator in 
wl12xx driver.
so I set boot_on as true for 32KG regulator as for power reason as follows.
Is it reasonable or not? or is there other solution can fix this issue? 
thanks.

diff --git a/arch/arm/mach-omap2/twl-common.c 
b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..843bade 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -374,6 +374,7 @@ static struct regulator_init_data omap4_vusb_idata = {
 static struct regulator_init_data omap4_clk32kg_idata = {
        .constraints = {
                .valid_ops_mask         = REGULATOR_CHANGE_STATUS,
+               .boot_on                = true,
        }, 
 };

Regards,
Xiao
