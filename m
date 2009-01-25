From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] board-omap3beagle: set i2c-3 to 100kHz
Date: Sun, 25 Jan 2009 04:04:10 -0800
Message-ID: <200901250404.11059.david-b@pacbell.net>
References: <1232873177-15531-1-git-send-email-koen@openembedded.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:46404 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753006AbZAYMEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 25 Jan 2009 07:04:13 -0500
In-Reply-To: <1232873177-15531-1-git-send-email-koen@openembedded.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@openembedded.org>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

On Sunday 25 January 2009, Koen Kooi wrote:
> From: Koen Kooi <koen@beagleboard.org>
> 
> Changing it do 100kHz is needed to make more devices works properly. Controlling the TI DLP Pico projector[1] doesn't work properly at 400kHz, 100kHz and lower work fine. EDID readout is unaffected by this change.
> 
> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
> 
> Signed-off-by: Koen Kooi <koen@beagleboard.org>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

:)

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index fe97bab..f7a6f7d 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -227,7 +227,9 @@ static int __init omap3_beagle_i2c_init(void)
>  #ifdef CONFIG_I2C2_OMAP_BEAGLE
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  #endif
> -	omap_register_i2c_bus(3, 400, NULL, 0);
> +	/* Bus 3 is attached to the DVI port where devices like the pico DLP 
> +	 * projector don't work reliably with 400kHz */
> +	omap_register_i2c_bus(3, 100, NULL, 0);
>  	return 0;
>  }
>  
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


