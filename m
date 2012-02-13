From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: OMAP34xx
Date: Mon, 13 Feb 2012 11:05:53 +0530
Message-ID: <4F38A139.4090501@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120212104132.GA17557@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202121148210.30322@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37204 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363Ab2BMFgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 00:36:01 -0500
Received: by mail-tul01m020-f175.google.com with SMTP id x4so8402590obh.34
        for <linux-omap@vger.kernel.org>; Sun, 12 Feb 2012 21:36:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1202121148210.30322@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

On Monday 13 February 2012 12:42 AM, Paul Walmsley wrote:
> Hi
>
> On Sun, 12 Feb 2012, Russell King - ARM Linux wrote:
>
>> The other allnoconfig issue is:
>>
>> arch/arm/mach-omap2/built-in.o:(.data+0xa3d0): undefined reference to `omap_i2c_reset'
>>
>> which looks like hwmod can't cope with the I2C_OMAP being disabled.
>>
>> I don't propose these are fixed for v3.3, but they certainly should be
>> fixed for v3.4.
> Thanks for the report.  Here's a patch for this for 3.4.  Compile-tested 
> only; will boot-test it as part of the v2 of the 3.4 hwmod changes.
>
Boot tested on omap4430 sdp.
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 12 Feb 2012 11:49:34 -0700
> Subject: [PATCH] ARM: OMAP2+: I2C: always compile I2C reset code, even if I2C
>  driver is not built
>
> During kernel init, we reset all IP blocks on the OMAP that we can,
> even if there is no driver compiled for that IP block.  Unlike most IP
> blocks, the I2C block requires some extra programming for this to
> work.  This reset code is incorrectly omitted when the I2C driver is
> deselected.  In this circumstance, the build breaks.  Fix by compiling
> the I2C reset code unconditionally.
>
> Problem reported by Russell King <linux@arm.linux.org.uk>.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap2/Makefile |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index fc9b238..0d5676c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>  
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
> -	 common.o gpio.o dma.o wd_timer.o display.o
> +	 common.o gpio.o dma.o wd_timer.o display.o i2c.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  hwmod-common				= omap_hwmod.o \
> @@ -182,9 +182,6 @@ obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
>  iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
>  obj-y					+= $(iommu-m) $(iommu-y)
>  
> -i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
> -obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
> -
>  ifneq ($(CONFIG_TIDSPBRIDGE),)
>  obj-y					+= dsp.o
>  endif

