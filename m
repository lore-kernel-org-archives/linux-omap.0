From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: sram: Add am33xx SRAM support (minimal)
Date: Mon, 13 Feb 2012 15:24:05 +0100
Message-ID: <87fweeyfp6.fsf@macbook.be.48ers.dk>
References: <1329113715-7634-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37074 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab2BMOYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 09:24:13 -0500
Received: by wics10 with SMTP id s10so3492724wic.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 06:24:12 -0800 (PST)
In-Reply-To: <1329113715-7634-1-git-send-email-afzal@ti.com> (Afzal Mohammed's
	message of "Mon, 13 Feb 2012 11:45:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, hvaibhav@ti.com

>>>>> "Afzal" == Afzal Mohammed <afzal@ti.com> writes:

 Afzal> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
 Afzal> Update SRAM start & size for am33xx SoC's.

 Afzal> Note: cpu_is_34xx() is true for am33xx also. Doing
 Afzal> cpu_is_am33xx() check after cpu_is_34xx() will not
 Afzal> achieve what we want due to the above reason.
 Afzal> Hence cpu_is_am33xx() is done before cpu_is_34xx()

 Afzal>  		} else {
 Afzal> -			if (cpu_is_omap34xx()) {
 Afzal> +			if (cpu_is_am33xx()) {
 Afzal> +				omap_sram_start = AM33XX_SRAM_PA;
 Afzal> +				omap_sram_size = 0x10000; /* 64K */
 Afzal> +			} else if (cpu_is_omap34xx()) {
 Afzal>  				omap_sram_start = OMAP3_SRAM_PA;
 Afzal>  				omap_sram_size = 0x10000; /* 64K */

I don't particular know the omap sram stuff, but doesn't the 33xx have
2x 64K blocks of SRAM?

 
 Afzal> +static inline int am33xx_sram_init(void)
 Afzal> +{
 Afzal> +	return 0;


I know you mentioned it in the commit message, but it might be good with
a comment here as well that this dummy function is needed to not get the 34xx
init function called for 33xx, so it doesn't get removed when somebody
decides to cleanup.

 Afzal> +}
 Afzal> +
 Afzal>  int __init omap_sram_init(void)
 Afzal>  {
 Afzal>  	omap_detect_sram();
 Afzal> @@ -379,6 +387,8 @@ int __init omap_sram_init(void)
 Afzal>  		omap242x_sram_init();
 Afzal>  	else if (cpu_is_omap2430())
 Afzal>  		omap243x_sram_init();
 Afzal> +	else if (cpu_is_am33xx())
 Afzal> +		am33xx_sram_init();
 Afzal>  	else if (cpu_is_omap34xx())
 Afzal>  		omap34xx_sram_init();
 

-- 
Bye, Peter Korsgaard
