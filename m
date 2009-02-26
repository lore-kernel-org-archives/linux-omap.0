From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 2/2] twl: usb: Add the resume() and suspend() methods
	to twl4030-usb.c (re)
Date: Thu, 26 Feb 2009 02:12:20 +0200
Message-ID: <20090226001219.GJ4639@gandalf>
References: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486@mail.gmail.com> <49A5DA3E.6040608@samsung.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49A5DA3E.6040608-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 26, 2009 at 08:54:38AM +0900, Minkyu Kang wrote:
> The MPU module can be waked up by the unexpected USB
> interrupt(HSUSB_MC_NINT). For instance, if the MUSB is working as
> peripheral mode and connected to a host PC, it can never enter the low
> power mode due to interrupts from the host PC. This patch added the
> feature that a board specific file can determines that TWL4030
> supplies the USB power or not in the low power mode. Disabling the USB
> power may save the power consumption.
> 
> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/otg/twl4030-usb.c |   25 +++++++++++++++++++++++++
>  include/linux/i2c/twl4030.h   |    1 +
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index 416e441..b725be2 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -256,6 +256,7 @@ struct twl4030_usb {
>  	u8			linkstat;
>  	u8			asleep;
>  	bool			irq_enabled;
> +	bool			suspend_enabled;

before we ack it and let it go through, could you please explain a bit
more the necessity of this ?

I mean, what you're doing here is that you would allow twl4030 to enter
low power mode even though we're connected to host side, meaning we
would never get awaken by the host side, right ?

Is that really wanted ? I mean, how would you then wake the device ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
