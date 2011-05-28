From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Re: [PATCH] free rev gpios when they are read, so others can read them later
Date: Sat, 28 May 2011 11:24:17 +0200
Message-ID: <91831E5F-5654-4133-AADC-9C3D6B86A63E@gmail.com>
References: <1306438716-68265-1-git-send-email-tasskjapp@gmail.com> <2DCF0893-4166-4604-887B-EDBC3643290A@gmail.com> <4DDF8AC9.60709@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40134 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab1E1JYU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 May 2011 05:24:20 -0400
Received: by ewy4 with SMTP id 4so879183ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 28 May 2011 02:24:19 -0700 (PDT)
In-Reply-To: <4DDF8AC9.60709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org

Hi Igor.
> 
> To be consistent with the rest of the file,
> can the white space here be "tabs" instead of spaces?
> 
> 
> -- 
> Regards,
> Igor.
> 

They can. New version attached. I'm don't know how to use git send-email to continue this thread with a comment to my patch, so it was done manually. Let me know if something else is less-than-optimal with my patches. Rookie contributor :)

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ff3a2c..54dbb7dd 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -106,6 +106,9 @@ static void __init omap3_beagle_init_rev(void)
 	beagle_rev = gpio_get_value(171) | (gpio_get_value(172) << 1)
 			| (gpio_get_value(173) << 2);
 
+	gpio_free_array(omap3_beagle_rev_gpios,
+			ARRAY_SIZE(omap3_beagle_rev_gpios));
+
 	switch (beagle_rev) {
 	case 7:
 		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
-- 
1.7.3.1

