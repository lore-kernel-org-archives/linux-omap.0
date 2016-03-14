From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mtd: nand: Fix support for NAND DMA prefetch
Date: Mon, 14 Mar 2016 09:17:19 -0500
Message-ID: <56E6C7EF.3030501@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <56E2CFF3.3030009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56E2CFF3.3030009-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 03/11/2016 08:02 AM, Roger Quadros wrote:
> Franklin,
>
> On 11/03/16 01:56, Franklin S Cooper Jr wrote:
>> NAND DMA prefetch has been broken for awhile and seems to have only
>> worked for SDMA based devices
>>
>> This patchset fixes DMA prefetch to work on both EDMA and SDMA devices
>>
>> Test on:
>> am335x gp evm
>> am437x gp evm
>> am37x gp evm
>>
>> This rev is pretty much the same as v2 which was blocked due to
>> dependencies to Roger's update GPMC/NAND rework.
>>
>> This updated rev removes this dependency.
>>
>> Also it fixes an issue that was introduced when the eDMA driver was
>> recently updated.
>>
>> Links to rev 3 patchset:
>> https://patchwork.ozlabs.org/patch/595631/
>> https://patchwork.ozlabs.org/patch/595626/
>> https://patchwork.ozlabs.org/patch/595628/
>> https://patchwork.ozlabs.org/patch/595630/
>> https://patchwork.ozlabs.org/patch/595627/
>> https://patchwork.ozlabs.org/patch/595629/
>>
>> Links to rev 2 patchset:
>> https://patchwork.kernel.org/patch/7408691/
>> https://patchwork.kernel.org/patch/7408681/
>> https://patchwork.kernel.org/patch/7408661/
>> https://patchwork.kernel.org/patch/7408641/
>> https://patchwork.kernel.org/patch/7408621/
>>
>> Franklin S Cooper Jr (7):
>>   ARM: OMAP2+: gpmc-nand: Set omap2-nand's parent dev to GPMC dev
>>   ARM: dts: am33xx: Fix GPMC dma properties
>>   ARM: dts: am437x: Fix GPMC dma properties
> Can you please fix the gpmc nodes in dm816x.dtsi and dm814x.dtsi as well?
> You can use linux-next tree or [1] to see the latest changes to these files
> that will end up in v4.6 and base your changes on that.
>
> [1] Tony's omap-for-v4.6/dt
> https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.6/dt

Sorry I didn't bother looking at dm816 and dm814 dtsi files
since I assumed it didn't use edma since the recent edma
updates didn't make updates for those devices. My mistake.
I'll update those dtsi files.
>>   mtd: nand: omap2: Support parsing dma channel information from DT
>>   mtd: nand: omap2: Start dma request before enabling prefetch
>>   mtd: nand: omap2: Fix high memory dma prefetch transfer
>>   ARM: OMAP2+: Update GPMC and NAND DT binding documentation
>>
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  7 +++++-
>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 +-
>>  arch/arm/boot/dts/am33xx.dtsi                      |  2 +-
>>  arch/arm/boot/dts/am4372.dtsi                      |  2 +-
>>  arch/arm/mach-omap2/gpmc-nand.c                    | 16 ++++++++++++-
>>  drivers/mtd/nand/omap2.c                           | 27 +++++++++-------------
>>  6 files changed, 35 insertions(+), 21 deletions(-)
>>
> cheers,
> -roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
