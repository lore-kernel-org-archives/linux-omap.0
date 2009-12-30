From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
 handling
Date: Wed, 30 Dec 2009 15:20:20 +0200
Message-ID: <1262179220.17250.4.camel@gandalf>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	 <1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	 <4B3B3720.9070205@ru.mvista.com> <1262174012.28789.178.camel@gandalf>
	 <4B3B504B.4020602@ru.mvista.com>  <1262178881.17250.1.camel@gandalf>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262178881.17250.1.camel@gandalf>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

adding Russell to Cc list as he might have comments.

On Wed, 2009-12-30 at 15:14 +0200, Felipe Balbi wrote:
> Hi,
> 
> On Wed, 2009-12-30 at 16:06 +0300, Sergei Shtylyov wrote:
> > Hello.
> > 
> > Felipe Balbi wrote:
> > 
> > >>    Why always "ick"?! Do you think OMAPs are the only boards using MUSB 
> > >> out there?
> > >>     
> > >
> > > err, I'm afraid you have to read more about clock framework. The clock
> > > name should not matter when you issue clk_get().
> > 
> >    It depends on the matching type determined from a clkdev matching 
> > table -- see dm644x_clks[] in arch/mach-davinci/dm644x.c as an example: 
> > 'struct davinci_clk' incorporates 'struct clk_lookup', and where its 1st 
> > member is initialized, the matching is done by device, where its second 
> > member is initialized, the matching is done by clock name -- see 
> > clk_find() in arch/arm/common/clkdev.c for the logic.
> 
> diff --git a/arch/arm/mach-davinci/dm644x.c
> b/arch/arm/mach-davinci/dm644x.c
> index 2cd0081..a0ad7b6 100644
> --- a/arch/arm/mach-davinci/dm644x.c
> +++ b/arch/arm/mach-davinci/dm644x.c
> @@ -306,7 +306,7 @@ struct davinci_clk dm644x_clks[] = {
>         CLK("davinci_mmc.0", NULL, &mmcsd_clk),
>         CLK(NULL, "spi", &spi_clk),
>         CLK(NULL, "gpio", &gpio_clk),
> -       CLK(NULL, "usb", &usb_clk),
> +       CLK("musb_hdrc", "usb", &usb_clk),
>         CLK(NULL, "vlynq", &vlynq_clk),
>         CLK(NULL, "aemif", &aemif_clk),
>         CLK(NULL, "pwm0", &pwm0_clk),
> 
> 
> there you are...

and the point is that we want to stop passing clock names down to the
driver so either we agree on using a generic name like "ick" or "usb",
or the clockdev implementation for that particular clock will match
device id. We sure need to think about clocks used by several devices,
we want to keep device id NULL, for sure.

Russell, how should we tackle this ?

-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
