From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/8] usb: musb: Change end point selection to use new IO
 access
Date: Mon, 24 Nov 2014 15:52:42 -0800
Message-ID: <20141124235241.GH2817@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
 <1416855906-13931-6-git-send-email-tony@atomide.com>
 <20141124233835.GB14728@tao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124233835.GB14728@tao>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org> [141124 15:40]:
> Hi Tony,
> 
> Thanks for the patch.
> 
> On Mon, Nov-24-2014 at 11:05:03 AM -0800, Tony Lindgren wrote:
> > This allows the endpoints to work when multiple MUSB glue
> > layers are built in.
> 
> Applied on top of 3.18-rc6 mainline and tested successfully on JZ4740.
> Been able to use ethernet-over-usb to access the internet on
> device. No issue as far as I'm concerned.

Great that's good to hear and thanks for testing.

Doing the DMA patches here right now.. For the DMA, I've set up
JZ4740 to use the MUSB_DMA_INVENTRA option by default, is that OK
or do you have some other DMA hardware on it?

If MUSB_DMA_INVENTRA does not work, and you don't have other DMA
hardware on it, we can pass MUSB_DMA_INVENTRA and leave the DMA
function pointers empty, and then the driver will bail out during
init unless the option for CONFIG_MUSB_PIO_ONLY is set.

Just that I could not figure out if that's the one to use grepping
the *_defconfig files.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
