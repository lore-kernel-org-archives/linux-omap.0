From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Fri, 16 May 2014 17:26:16 +0300
Message-ID: <53762008.4010808@ti.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com> <1400238230-26357-3-git-send-email-pekon@ti.com> <537602FE.4020108@ti.com> <20980858CB6D3A4BAE95CA194937D5E73EACDA8A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785AbaEPO0X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 10:26:23 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACDA8A@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On 05/16/2014 04:58 PM, Gupta, Pekon wrote:
> Hi Roger,
> 
>> From: Quadros, Roger
>>
> [...]
>>> +&gpmc {
>>> +	status = "okay";
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&nand_flash_x8>;
>>> +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
>>> +	nand@0,0 {
>>> +		reg = <0 0 0x37c>;	/* device IO registers */
>>
>> This register space is used by the parent GPMC node as well as the NAND controller. So doing a
>> request_and_ioremap() on this space will fail as it is already taken by the GPMC driver.
>>
>> Further, the GPMC register space doesn't map to the GPMC memory map created by this Chip select
>> but it is mapped to L3_IO space. i.e. (physical address 0x6e00 0000)
>>
>> We could have split the GPMC register space into GPMC part and NAND part but to add to the
>> complexity, the register spaces for GPMC vs NAND are interleaved so it can't be easily split up.
> Sorry I din't get this part.
> NAND is one of the devices supported by GPMC controller.
> Hardware wise the it's the same engine is used for NAND, NOR and OneNAND

But GPMC register space is only used for 2 things, Chip Select configuration and NAND driver.

GPMC registers are not used for NOR, OneNAND or other memory accessible devices. They don't need GPMC registers because their registers are mapped in the GPMC I/O space.

> and even other parallel interfaces like Camera, Ethernet, etc..
> So how can be NAND and GPMC registers space be splitted ?

- all Chip select configuration registers i.e. GPMC_CONFIG* should go to GPMC device
- all the GPMC_NAND_*, GPMC_ECC_, and GPMC_BCH_* registers go to NAND device

The tricky part is that all these registers are interleaved among each other and so the register map is fragmented.

> 
> I see gpmc.c as generic controller driver, which just does initializations
> and registering the device. Then it's upto the individual protocol drivers
> to probe the device and attach it to respective sub-system; like;
> (a) drivers/mtd/nand/omap2.c  for NAND
> (b) drivers/mtd/chips/cfi_probe.c  for NOR
> ...

omap2.c needs GPMC registers, but cfi_probe.c and others don't need them.

> 
> 
>> The way
>> the NAND driver is currently written is that it expects the register addresses to come via platform data,
>> primarily to get around this address interleaving issue.
>>
> Yes, that is right.
> I don't know the historical reasons but that is correct also because,
> (1) large set of GPMC register configurations are common across all
>  types of devices (like NAND, NOR, OneNAND, Ethernet). These
>  register configurations define the signal timings and physical attributes
>  of device (like device width, etc).
> 
> (2) Individual protocol drivers (a) and (b) only uses a sub-set of registers
>  for transferring data, much of which is based on type of protocol.
>  
> So, large part of GPMC configurations remains static and can be
> Shared across all types of devices, hence those are put in gpmc.c

Right, so just the GPMC configuration part needs to be with GPMC driver. The NAND controller bits don't need to be.

> 
> 
>> Apart from the GPMC register space, the NAND controller uses 4 bytes of GPMC memory map for I/O,
>> and that is something that could be reflected here.
>>
>> e.g.
>> 		reg = <0 0 4>;		/* NAND I/O space */
>>
>> But still, the start address can't be 0 and has to be assigned when this CS region is mapped. It is still
>> unclear to me how that can be done.
>>
> Yes, NAND is not directly mapped. So only 4-bytes of I/O size will do.
> But where to map these 4 bytes ? and which 4-bytes to map.
> So I have included complete GPMC register space-size.

That is not the right solution. The mapping is done in the gpmc driver in gpmc_cs_request()/gpmc_cs_remap().
If a random address (meeting GPMC alignment needs) is specified within the GPMC 1GB space, the GPMC driver should configure the CS to map
to that address. If 0 is specified then the GPMC must map it automatically to a sane address and then update the reg property before instantiating the child node's platform device.

For the NAND controller, we don't even create a child device based on the OF node but instead legacy platform device, so this reg property isn't being even used.

> 
> Also since GPMC has a constrain that every chip-select must have
> minimum of 16MB memory. So we specify it via  <range> property
> to keep GPMC mapping consistent across all NAND, NOR, OneNAND, etc..
> 
> If you have any better approach in mind for keeping consistent
> memory mapping across different types of devices, then please suggest ..
> I'll try to get this done in next set of patches, if not these.
> Or
> May be you can take over as part of GPMC transition.

As the driver doesn't rely on the reg address portion (at least for the NAND driver), you can leave this option out for now.

cheers,
-roger
