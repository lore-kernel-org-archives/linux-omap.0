From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 12 Aug 2010 10:03:49 +0300
Message-ID: <20100812100349.8f151b5b.jhnikula@gmail.com>
References: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43672 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0HLHD7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 03:03:59 -0400
Received: by ewy23 with SMTP id 23so479423ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 00:03:58 -0700 (PDT)
In-Reply-To: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi

On Wed, 11 Aug 2010 18:37:40 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> Due to the omap3530 ES3.0 Silicon being used on both the
> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
> routines to differentiate the Beagle Boards.
> 
> However gpio pins 171,172,173 where setup for this prupose, so 
> lets use them.
> 
> Tested on Beagle Revisions: B5, C2, C4, and xMA
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   60 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/board.h |   23 ++++++++++++
>  2 files changed, 83 insertions(+), 0 deletions(-)
> 
...
> +	beagle_rev = gpio_get_value(171) | (gpio_get_value(172) << 1)
> +			| (gpio_get_value(173) << 2);
> +
> +	switch (beagle_rev) {
> +	case 7:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
> +		break;
> +	case 6:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
> +		break;
> +	case 5:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
> +		break;
> +	case 0:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> +		break;
> +	default:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> +	}

My C2 reads as 2 and I have U-Boot 2009.01-dirty (Feb 19 2009 -
12:22:31). I believe these pins are not muxed correctly with that
U-Boot version.

Therefore kernel should remux those pins so that version is detected
right independently of bootloader version. Detections works fine if I
add these:

	omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
	omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
	omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);


-- 
Jarkko
