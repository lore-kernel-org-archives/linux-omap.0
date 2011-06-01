From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: beagle: add support for beagleboard xM revision
 C
Date: Wed, 1 Jun 2011 09:43:55 +0300
Message-ID: <20110601064355.GB8696@atomide.com>
References: <1306503133-31996-1-git-send-email-koen@dominion.thruhere.net>
 <20110530143411.GG11352@atomide.com>
 <12BBA6F3-601A-472B-AB24-FCEA7DCED29D@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16863 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754034Ab1FAGn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 02:43:57 -0400
Content-Disposition: inline
In-Reply-To: <12BBA6F3-601A-472B-AB24-FCEA7DCED29D@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap List <linux-omap@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Joel A Fernandes <agnel.joel@gmail.com>

* Koen Kooi <koen@dominion.thruhere.net> [110531 21:09]:
> 
> Op 30 mei 2011, om 16:34 heeft Tony Lindgren het volgende geschreven:
> 
> > Hi,
> > 
> > * Koen Kooi <koen@dominion.thruhere.net> [110527 06:28]:
> >> 
> >> @@ -123,9 +126,13 @@ static void __init omap3_beagle_init_rev(void)
> >> 		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> >> 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> >> 		break;
> >> +	case 2:
> >> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> >> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
> >> +		break;
> >> 	default:
> >> 		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
> >> -		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
> >> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
> >> 	}
> >> }
> > 
> > Maybe just set up static struct omap3_beagle that contains the
> > various things to initialize. Then initialize it in omap3_beagle_init_rev
> > above.
> > 
> > Otherwise we'll end up adding more and more omap3_beagle_get_rev and
> > cpu_is_omap tests to this file and it will become hard to maintain.
> > 
> >> @@ -253,7 +260,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
> >> {
> >> 	int r, usb_pwr_level;
> >> 
> >> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> >> +	if (cpu_is_omap3630()) {
> >> 		mmc[0].gpio_wp = -EINVAL;
> >> 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
> >> 		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
> > 
> > This would become:
> > 
> > 	mmc[0].gpio_wp = beagle.gpio_wp;
> > 
> >> @@ -275,11 +282,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
> >> 	 * high / others active low)
> >> 	 * DVI reset GPIO is different between beagle revisions
> >> 	 */
> >> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> >> -		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
> >> +	if (cpu_is_omap3630()) {
> >> 		beagle_dvi_device.reset_gpio = 129;
> >> 		/*
> >> -		 * gpio + 1 on Xm controls the TFP410's enable line (active low)
> >> +		 * gpio + 1 on xM controls the TFP410's enable line (active low)
> >> 		 * gpio + 2 control varies depending on the board rev as below:
> >> 		 * P7/P8 revisions(prototype): Camera EN
> >> 		 * A2+ revisions (production): LDO (DVI, serial, led blocks)
> > 
> > This would be just:
> > 
> > 	usb_pwr_level = beagle.usb_pwr_level;
> > 
> > And so on.
> 
> Tony, thanks for the feedback! The change you want is a bit too much for my C knowledge, but Joel will but picking it up from here.

Hmm, not much there to it actually :) I'm sure you too can do it
little help from Joel.

Tony
