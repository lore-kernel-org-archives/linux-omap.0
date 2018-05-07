From: Tony Lindgren <tony@atomide.com>
Subject: Re: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
 support
Date: Mon, 7 May 2018 08:08:21 -0700
Message-ID: <20180507150821.GM98604@atomide.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <20180502145100.GK98604@atomide.com>
 <5cc906da15da45ab96e06957f878b65b@ti.com>
 <20180503141759.GP98604@atomide.com>
 <f0ea5260b3e2413aab4780b203ff24a4@ti.com>
 <20180506165621.GL98604@atomide.com>
 <a4dd3009f0f5492d8756f42c11590423@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4dd3009f0f5492d8756f42c11590423@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Reizer, Eyal" <eyalr@ti.com>
Cc: Eyal Reizer <eyalreizer@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loewy, Chen" <c-loewy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr@ti.com> [180507 06:57]:
> Hi Tony,
> 
> > 
> > Yeah my guess is that the reason for the separate GPIO interrupt was
> > that on omap3 we did not have SDIO interrupt working for years. This was
> > because of the issues related to padconf interrupts for off mode.
> > 
> > We now have Linux generic wakeirq support working with SDIO and it has
> > been confirmed to work also for off mode with mwifiex at least. So
> > there should be no reason to not also use the SDIO interrupt.
> > 
> 
> There is more to this than just the padconf.
> Using in-band interrupt instead of the out of band one requires
> Supporting a feature called "Asynchronous interrupts in 4Bit mode"
> Which is part of SDIO 3.0 spec:
> https://www.sdcard.org/downloads/pls/pdf/index.php?p=PartE1_SDIO_Simplified_Specification_Ver3.00.jpg&f=PartE1_SDIO_Simplified_Specification_Ver3.00.pdf&e=EN_SSE1
> 
> Take a look at page 41 at the bottom part of the table.
> Wilink8 supports this feature but AFAIK this support is still not part of the 
> mmc/sdio core in the Linux kernel.
> If we want wilink8 to trigger a host wakeup using the in-band interrupt instead 
> Of the wlan_irq pin we would need to enable/use this feature.

Well the SDIO dat line interrupt is working just fine with
mwifiex_sdio driver and runtime PM like I said :)

> I did use it internally in the past and was able to patch the Ubuntu kernel 
> (3.5.0 at that time) to use wilink8 in a standard SD Card slot of an Ubuntu Laptop 
> while removing the use of wlan_irq pin completely.
> However this was an experimental patch set written by a third party 
> that was not up-steamtable at that time.
> I do have this patch set somewhere...
> 
> It is similar to the following patch which is not  upstream as well for some reason:
> https://gitlab.com/k2wl/g2_kernel/commit/5c4970fdaa50422d7ea7220efa20fb35148a4bca
> It is not the only patch needed, there are a couple of additional patches needed 
> for fully using it from driver.
> I did check latest Linux-next and don't see this support there. Not sure why.

Hmm not sure if this is needed here. When things enter idle, the whole
SDIO block is off and the SDIO dat interrupt is delivered as wakeirq to
the pinctrl-single driver instead that manages padconf wake events.
Then we have runtime PM wake up MMC subsystem and the SDIO dat line
interrupt is still there and will trigger as it's level sensitive.

So the test to do would be simply configure wlcore to use SDIO dat line
interrupt instead of the GPIO interrupt and configure a wakeirq for
the board on the SDIO dat line. Sounds like I need to get my wlcore
runtime PM patches ready though as that is needed for using the wakeirq.

Regards,

Tony
