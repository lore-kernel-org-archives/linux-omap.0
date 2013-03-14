From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: dts: Various OMAP2+ device-tree updates
Date: Thu, 14 Mar 2013 11:04:49 -0500
Message-ID: <5141F521.1020005@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com> <5141E55E.9040801@ti.com> <CAAwP0s2BW-GTKsS0UpAWiMbRTFyDzgeUmOCw2p0CaB3RDKOnBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933661Ab3CNQFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 12:05:10 -0400
In-Reply-To: <CAAwP0s2BW-GTKsS0UpAWiMbRTFyDzgeUmOCw2p0CaB3RDKOnBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/14/2013 11:02 AM, Javier Martinez Canillas wrote:
> On Thu, Mar 14, 2013 at 3:57 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Salut Jon,
>>
>> On 03/08/2013 06:27 PM, Jon Hunter wrote:
>>> Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.
>>>
>>> The DMA, PMU and OMAP3430 SDP board changes have been sent before
>>> individually but re-sending here as a complete series for v3.10.
>>>
>>> This is based upon v3.9-rc1 and the OMAP3 GPMC binding from Florian
>>> Vaussard [1] and OMAP5 DT SPI patch from Felipe Balbi [2].
>>>
>>> [1] https://patchwork.kernel.org/patch/2057111/
>>
>> I've tried to follow the series review, and it seems that Florian was
>> considering sending some other patches. It is not clear if this is a new
>> version of the series or some additional patches.
>>
> 
> Hi Benoit,
> 
> According to [1] Jon suggested that it was not necessary to map all
> the 16MB for the GPMC mapped register address space since in practice
> is a very small fraction of that size is used.
> 
> I had the following patch but I did never post it because Jon said
> that the I/O memory mapping is page-aligned and the minimum page
> size for ARM is 4KB anyways, so there is no functional difference
> between using 0x1000 or 0x02d0.
> 
> But now reading [2] I see that you prefer to do what the documentation
> said and don't assume any the page size / alignment.
> 
> [2]: https://patchwork.kernel.org/patch/2239741/
> 
> From 68edff5a102bb8fc81e006738baa456eb69f080a Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Wed, 27 Feb 2013 02:30:51 +0100
> Subject: [PATCH] ARM: dts: OMAP3: reduce GPMC mapped registers address space
> 
> Currently the OMAP General-Purpose Memory Controller (GPMC) device
> node maps 16 MB of address space for its hardware registers.
> 
> This is because the OMAP Technical Reference Manual says that the
> GPMC module register address space size is 16 MB. But in practice
> the maximum address offset used by a GPMC register is 0x02d0.
> 
> So, there is no need to map such a big address space for GPMC regs.
> 
> This change was suggested by Jon Hunter [1].
> 
> [1]: https://patchwork.kernel.org/patch/2057111/
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 2ddae38..a60eaf1 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -407,7 +407,7 @@
>  		gpmc: gpmc@6e000000 {
>  			compatible = "ti,omap3430-gpmc";
>  			ti,hwmods = "gpmc";
> -			reg = <0x6e000000 0x1000000>;
> +			reg = <0x6e000000 0x02d0>;
>  			interrupts = <20>;
>  			gpmc,num-cs = <8>;
>  			gpmc,num-waitpins = <4>;
> 

Thanks!

Acked-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
