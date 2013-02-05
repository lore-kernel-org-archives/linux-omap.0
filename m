From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
Date: Tue, 5 Feb 2013 10:40:15 -0800
Message-ID: <20130205184014.GK25185@atomide.com>
References: <50FE64DC.2030808@ti.com>
 <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com>
 <20130204195251.GS22517@atomide.com>
 <5110D4ED.6030306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754340Ab3BESkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 13:40:17 -0500
Content-Disposition: inline
In-Reply-To: <5110D4ED.6030306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130205 01:49]:
> Hi Tony,
> 
> On 02/04/2013 08:52 PM, Tony Lindgren wrote:
> > Looks like this now adds some new section warnings:
> > 
> > WARNING: vmlinux.o(.text+0x34124): Section mismatch in reference from the function sdp3430_twl_gpio_setup() to the function .init.text:omap_twl4030_audio_init()
> > The function sdp3430_twl_gpio_setup() references
> > the function __init omap_twl4030_audio_init().
> > This is often because sdp3430_twl_gpio_setup lacks a __init 
> > annotation or the annotation of omap_twl4030_audio_init is wrong.
> > 
> > WARNING: vmlinux.o(.text+0x34b8c): Section mismatch in reference from the function zoom_twl_gpio_setup() to the function .init.text:omap_twl4030_audio_init()
> > The function zoom_twl_gpio_setup() references
> > the function __init omap_twl4030_audio_init().
> > This is often because zoom_twl_gpio_setup lacks a __init 
> > annotation or the annotation of omap_twl4030_audio_init is wrong.
> 
> For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my rolling
> kernel config...

At least gcc version 4.3.5 (Debian 4.3.5-4) shows them. What's
the compiler you have? 
 
> > These can be fixed with the following patch, but I suspect some
> > of these cannot be __init/__initdata if the driver reprobes.
> > 
> > Can you please check this? I'll hold on sendinf off
> > this branch until it's been checked and fixed properly.
> 
> I think this is not the correct way. the *_twl_gpio_setup() is called from the
> gpio-twl4030 driver's platform_driver probe function which if I'm not mistaken
> is not __init.
> 
> I think we should remove the __init from the omap_twl4030_audio_init() in
> twl-common.c
> With this change I do not have section mismatch either.

Yes let's do that rather than start copying things around. I'll apply
the following fix to the omap-for-v3.9/twl branch.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Feb 2013 10:36:21 -0800
Subject: [PATCH] ARM: OMAP2+: Fix twl section warnings related to omap_twl4030_audio_init

With the recent twl related changes we can now get:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x15f88): Section mismatch in
reference from the function sdp3430_twl_gpio_setup() to the function
.init.text:omap_twl4030_audio_init()
The function sdp3430_twl_gpio_setup() references
the function __init omap_twl4030_audio_init().
This is often because sdp3430_twl_gpio_setup lacks a __init
annotation or the annotation of omap_twl4030_audio_init is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x16968): Section mismatch in
reference from the function zoom_twl_gpio_setup() to the function
.init.text:omap_twl4030_audio_init()
The function zoom_twl_gpio_setup() references
the function __init omap_twl4030_audio_init().
This is often because zoom_twl_gpio_setup lacks a __init
annotation or the annotation of omap_twl4030_audio_init is wrong.

Fix this by removing __init from omap_twl4030_audio_init() as
suggested by Peter Ujfalusi <peter.ujfalusi@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -536,7 +536,7 @@ static struct platform_device audio_device = {
 	.id		= -1,
 };
 
-void __init omap_twl4030_audio_init(char *card_name,
+void omap_twl4030_audio_init(char *card_name,
 				    struct omap_tw4030_pdata *pdata)
 {
 	if (!pdata)
@@ -549,7 +549,7 @@ void __init omap_twl4030_audio_init(char *card_name,
 }
 
 #else /* SOC_OMAP_TWL4030 */
-void __init omap_twl4030_audio_init(char *card_name,
+void omap_twl4030_audio_init(char *card_name,
 				    struct omap_tw4030_pdata *pdata)
 {
 	return;
