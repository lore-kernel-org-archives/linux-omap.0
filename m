From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] musb: Inform user when gadget cable is disconnected
Date: Tue, 3 Nov 2009 09:37:12 +0200
Message-ID: <20091103073712.GA30172@nokia.com>
References: <1257230140-12958-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1257230140-12958-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 03, 2009 at 07:35:39AM +0100, ext Ajay Kumar Gupta wrote:
> Currently we don't see any message to inform user that gadget cable is
> successfully disconnected leading to suspicion if everything is fine at
> driver therefore adding an informative print message in gadget
> disconnect path.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 3a61ddb..ec67ec7 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -795,6 +795,10 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
>  #ifdef CONFIG_USB_GADGET_MUSB_HDRC
>  		case OTG_STATE_B_PERIPHERAL:
>  		case OTG_STATE_B_IDLE:
> +			printk(KERN_INFO "musb %s gadget disconnected.\n",
> +				musb->gadget_driver
> +				? musb->gadget_driver->driver.name
> +				: "");

i don't think this is so useful since no normal user will be reading
dmesg anyway. User will get this state via
/sys/devices/platform/musb_hdrc/mode, which is sysfs_notified and
HAL/DeviceKit can use that to show pretty UI messages to user.

I'm currently moving some sysfs files to the transceiver level and
creating a more generic set of sysfs files so that we could have a
generic hald-addon or DeviceKit daemon for handling that for any
transceiver.

I have some under-development patches available at [1] if you want to
look. The commit regarding this is on [2].

[1] http://gitorious.org/usb/usb/commits/otg-rework
[2] http://gitorious.org/usb/usb/commit/121ff1e9f17ffa56692b63305bf55e72216df3eb

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
