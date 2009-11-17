From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 3/8] musb: Update musb_init() call for all OMAP3 boards
Date: Tue, 17 Nov 2009 19:30:57 +0300
Message-ID: <4B02CFC1.3090601@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com> <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:

> musb_init() has been modified to pass board specific data so updating
> this function call from all OMAP3 boards.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

[...]

> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 1145a25..0e9380c 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -124,12 +124,6 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	/* .clock is set dynamically */
>  	.set_clock	= musb_set_clock,
>  	.config		= &musb_config,
> -
> -	/* REVISIT charge pump on TWL4030 can supply up to
> -	 * 100 mA ... but this value is board-specific, like
> -	 * "mode", and should be passed to usb_musb_init().
> -	 */
> -	.power		= 50,			/* up to 100 mA */

    That should obviously be a part of patch 1/8...

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
