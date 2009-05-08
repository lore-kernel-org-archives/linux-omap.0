From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Fri, 8 May 2009 11:04:54 +0300
Message-ID: <94a0d4530905080104k38e01649q3b8c9617c0e8a5b0@mail.gmail.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
	 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
	 <20090508.071410.173868238.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:34764 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758037AbZEHIEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 04:04:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so70449fga.17
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2009 01:04:54 -0700 (PDT)
In-Reply-To: <20090508.071410.173868238.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, felipe.contreras@nokia.com, tony@atomide.com, h-kanigeri2@ti.com

On Fri, May 8, 2009 at 7:14 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi Felipe,
>
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
> Date: Thu, 7 May 2009 22:11:06 +0200
>
>> This patch series cleanups up a bit the opap3-iommu device registration and
>> then allows registration from other parts of the code.
>
> I think that this part of code is just a simple conventional
> platform_device registration and there may be no need to add more
> complexicity by introducing a new special structure/function just for
> a workaround of a client module("tidspbridge"). Also having these
> device registrations here and there doesn't look so nice, looking at
> other ones around kernel.

First of all, it's not a workaround. Fake dependencies are bad. iommu
should not depend on isp or iva2 (or how they are implemented), it's
the other way around.

Let's say you disable isp, do you want iommu to add the isp iommu
device (same for iva2)? What happens if you don't want either isp or
iva2 in the kernel, what is the point of having iommu?

Second, it's not introducing any new structure, the structure is
internal, you can remove it if you want and implement the same with a
select or any way you want, I just thought an internal structure was
easier to follow.

And third, this kind of device registration is used all over the place, look at:
omap_mmc_add
pxa2xx_set_spi_info
at32_add_device_psif
at32_add_device_twi
at32_add_device_mci
at32_add_device_pwm
at32_add_device_usba
at32_add_device_ide
at32_add_device_cf
at32_add_device_nand
at32_add_device_ac97c
at32_add_device_abdac
txx9_ethaddr_init
txx9_physmap_flash_init
txx9_iocled_init
mv64x60_mpsc_device_setup
mv64x60_eth_device_setup
mv64x60_i2c_device_setup
mv64x60_wdt_device_setup
ipmi_bmc_register
aem_init_aem1_inst
aem_init_aem2_inst
w1_ds2760_add_slave
of_snd_soc_register_device

>> Currently the iva2 code (tidspbridge) is not using iommu, therefore it can't be
>> used as-is with the current omap iommu. By allowing devies to be registered
>> externaly (either isp, or iva2) this problem goes away.
>
> Fixing tidspbridge itself is the way to go, and it seems that Hari has
> already verified this iommu with tidspbridge and he's pointed out some
> of missing features(*1). I hope that tidspbridge will start to use
> iommu soon.

Yes, definitely, but that's not an excuse not to make iommu more
extensible. With my patch the iommu can be merged as is and would not
*require* any change in tidspbridge. When the tidspbridge is ready, it
would be a matter of adding one line.

Also, it's better to have independent branches. It would be ugly to
modify iommu code from the tidspbridge branch depending on whether or
not the migration to iommu have happened.

And finally, suppose you load the bridgedriver on-demand, with my
patch the iva2 iommu device will be created *only* when the
bridgedriver is loaded, and when the bridgedriver itself is unloaded
it can remove the iva2 iommu device. So essentially we'll have only
the iommu devices that we really need.

Now I ask the question the other way around, what do we loose if we
apply these patches?

-- 
Felipe Contreras
