From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/2] musb: musb: dsps: support multiple instances
Date: Tue, 18 Jun 2013 10:34:41 +0200
Message-ID: <51C01BA1.6040009@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de> <1371482014-5244-2-git-send-email-bigeasy@linutronix.de> <20130618082725.GG5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618082725.GG5461-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 06/18/2013 10:27 AM, Felipe Balbi wrote:
>> diff --git a/drivers/usb/musb/musb_dsps.c
>> b/drivers/usb/musb/musb_dsps.c index e1b661d..d9ff390 100644 ---
>> a/drivers/usb/musb/musb_dsps.c +++
>> b/drivers/usb/musb/musb_dsps.c @@ -415,9 +415,14 @@ static int
>> dsps_musb_init(struct musb *musb) /* mentor core register starts
>> at offset of 0x400 from musb base */ musb->mregs +=
>> wrp->musb_core_offset;
>> 
>> -	/* NOP driver needs change if supporting dual instance */ -
>> usb_nop_xceiv_register(); -	musb->xceiv =
>> usb_get_phy(USB_PHY_TYPE_USB2); +	if (!glue->dev->of_node) { +
>> /* This hack works only for a single instance. */ +
>> usb_nop_xceiv_register(); +		musb->xceiv =
>> usb_get_phy(USB_PHY_TYPE_USB2);
> 
> I think you can drop this altogether, am335x is DT-only anyway :-)

Yes, but this is also used by:

$ git grep "musb-ti81xx"
arch/arm/mach-omap2/usb-musb.c:         name = "musb-ti81xx";
drivers/usb/musb/musb_dsps.c:           .name   = "musb-ti81xx",

Is that one also am33xx?

> 
>> +	} else { +		musb->xceiv =
>> devm_usb_get_phy_by_phandle(glue->dev, "phys", +
>> musb->config->instance); +	}
> 
> after doing all this, perhaps we should re-factor phy_get into 
> musb_core.c, so that we can remove this sort of support from all
> glue layers.

So keep this is as is and add later a phy_get into musb? I would have
check if everyone has a phy instance but I guess so.

Sebastian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRwBucAAoJEHuW6BYqjPXRhK4P/3SjhljlSmWO0XN1pjXCu+L+
m6yxlz+epFfJSnXKX8FWmVQOahtQrbclv+KhcMo/KWeHj/epp30u924avkexwOc7
RRPCYEldhJdySNEkv14MpAan5WfOXNm8NuD7wCnrADahQxw6vQPoU3wnDIRKuW5i
b4kR+V2cSJatlg5tNeXiYR+LLygtSaBprBwcdUSeJ/BsivZBYx4TnwQ/LpMD24br
vORIbivMf+SKkJAmxBqHg956L38vL6C3iLYR0GHnk7a4x9cQ4Kk5jJVz6HbphYkJ
zzIrYojFXQ5SE7F4+jyEidUx2hQnNhNT6TAFGXG9fCpdNoi+3zhxBKUW1b7aIAHP
fbQJbNM4wRNBmxKvQPTLzlsnLTFbjfBb+vd1KBst8niIjLfhaYiV9oLiwAUilrvw
ugndxyzGgfKWbBDwcS6pVNwfP3eE54ZunOrRJnS/EF1GRrC1yaPZb0xuTxuMiqN2
97R9H1SPyUv9qJidB/EoJKFMyoq6fWlNTMTMGK+S80ctdQp+bOWdNcpJGaPx7XGc
8z+AKoQZapC/TunWqrJrNz6mcTh2ibyG+hfTD7FJULq9NYM7oAtAn9MOser4gwTB
YxsJnEIj29TNJQx4g7/29rr+vNKNX1DPNTgW7r3v4JFKPClx4wZpXLe9qOG48LKa
ciA5Sp9sWio6AwtyhEyl
=xL1i
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
