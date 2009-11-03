From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: beagle: Fix USB host port power control
Date: Tue, 3 Nov 2009 09:21:39 -0800
Message-ID: <20091103172139.GL8981@atomide.com>
References: <1256371194-22944-1-git-send-email-jhnikula@gmail.com>
 <CD99E8BE-6FBB-4975-9072-A9BE16B1A00D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53768 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZKCRVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:21:36 -0500
Content-Disposition: inline
In-Reply-To: <CD99E8BE-6FBB-4975-9072-A9BE16B1A00D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [091103 06:11]:
> Any comments on this, I need this on beagleboard to make ehci work.

Looks like a fix to me, will queue.

Tony
 
> regards,
> 
> Koen
> 
> Op 24 okt 2009, om 09:59 heeft Jarkko Nikula het volgende geschreven:
> 
> >The host port power is enabled by driving the nEN_USB_PWR low as
> >stated in
> >the comment. This fix is originally from Steve Sakoman
> ><steve@sakoman.com>.
> >
> >Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> >Cc: Steve Sakoman <steve@sakoman.com>
> >---
> >arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
> >1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> >b/arch/arm/mach-omap2/board-omap3beagle.c
> >index 6cb99f6..7ad9846 100644
> >--- a/arch/arm/mach-omap2/board-omap3beagle.c
> >+++ b/arch/arm/mach-omap2/board-omap3beagle.c
> >@@ -162,7 +162,7 @@ static int beagle_twl_gpio_setup(struct device
> >*dev,
> >
> >	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active
> >low) */
> >	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
> >-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
> >+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> >
> >	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
> >	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> >-- 
> >1.6.3.3
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-
> >omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
