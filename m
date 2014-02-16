From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 0/2] usb: musb dsps updates
Date: Sun, 16 Feb 2014 23:03:11 +0100
Message-ID: <20140216220311.GB31006@pengutronix.de>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389950556-6453-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jan 17, 2014 at 10:22:34AM +0100, Markus Pargmann wrote:
> Hi,
> 
> The two remaining patches from the previous series "usb: musb bugfixes". In v4
> I used the device name for the debugfs root dir and added a commit message to
> the second patch.

Felipe, could you please have a look at this?

Thanks,

Markus

> 
> Regards,
> 
> Markus
> 
> 
> Markus Pargmann (2):
>   usb: musb: dsps, debugfs files
>   usb: musb: dsps, use devm_kzalloc
> 
>  drivers/usb/musb/musb_dsps.c | 58 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
