From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH] ARM: dts: am33xx: Re-arrange the USB dt to reflect
 the h/w configuration
Date: Wed, 14 May 2014 14:50:35 -0700
Message-ID: <20140514215034.GL27426@atomide.com>
References: <1399617068-19826-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399617068-19826-1-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [140508 23:34]:
> Re arrange the USB dt for AM33xx to take it a bit closer
> to the hardware configuration.
> 
> The USBSS is designed as follows
> 
> USB control Module	0x44e10_0620
> 
> USBSS			0x4740_0000
> 
> USB0			0x4740_1000
> USB0_PHY		0x4740_1300
> USB0_CORE		0x4740_1400
> 
> USB1			0x4740_1800
> USB1_PHY		0x4740_1b00
> USB1_CORE		0x4740_1c00
> 
> CPPI DMA Controller	0x4740_2000
> CPPI DMA Scheduler	0x4740_3000
> Queue Manager		0x4740_4000
> 
> So model the DT as follows
> USBSS {
>     usb_ctrl_mod: {
>         0x44e10_0620
>     }
>     usb0: {
>     0x4740_1000
>     0x4740_1400
>     }
>     usb0_phy:{
>     0x4740_1300
>     }
>     usb1:{
>     0x4740_1800
>     0x4740_1c00
>     }
>     usb1_phy: {
>     0x4740_1b00
>     }
>     cppi41dma: {
>     0x4740_2000
>     0x4740_3000
>     0x4740_4000
>     }
> }

Is this just a cosmetic change or is this trying to workaround
some edma related init order issue?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
