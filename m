From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2/4: PM: Boot message is not an error/info,	and not
 helpful, remove it
Date: Mon, 30 May 2011 19:14:11 +0530
Message-ID: <4DE39F2B.3040506@ti.com>
References: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com> <4DE39D40.2060500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47328 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751745Ab1E3NoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 09:44:18 -0400
Received: by mail-yw0-f43.google.com with SMTP id 6so1937452ywa.2
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 06:44:17 -0700 (PDT)
In-Reply-To: <4DE39D40.2060500@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

On 5/30/2011 7:06 PM, Sergei Shtylyov wrote:
> Hello.
>
> Santosh Shilimkar wrote:
>
>> The commit '99aa18278e' removed the boot messege for OMAP3. Do the same
>
> Please specify that commit's summary in parens -- for the human readers.
> Oh, and you don't need quotes around commit ID too.
>
Yes I missed that. Updated patch below.

Regards
Santosh

 From 53e986a2a43dc204146af99c2d7a906dba781ea0 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 30 May 2011 15:52:01 +0530
Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and not 
helpful, remove it

The commit 99aa18278e (OMAP3: PM: Boot message is not an error,
and not helpful, remove it), removed the boot message for OMAP3.
Do the same for OMAP2 and OMAP4 since it's really just noise in the
boot log and PM init is always called.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
  arch/arm/mach-omap2/pm24xx.c |    1 -
  arch/arm/mach-omap2/pm44xx.c |    2 --
  2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index df3ded6..5970759 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -442,7 +442,6 @@ static int __init omap2_pm_init(void)
  	if (!cpu_is_omap24xx())
  		return -ENODEV;

-	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
  	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
  	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..a6259d6 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -103,8 +103,6 @@ static int __init omap4_pm_init(void)
  	if (!cpu_is_omap44xx())
  		return -ENODEV;

-	pr_err("Power Management for TI OMAP4.\n");
-
  	ret = pwrdm_for_each(pwrdms_setup, NULL);
  	if (ret) {
  		pr_err("Failed to setup powerdomains\n");
-- 
1.6.0.4

