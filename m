From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH RESEND v5 0/4] OMAP GPMC DT bindings
Date: Thu, 29 Nov 2012 12:58:04 +0100
Message-ID: <50B74DCC.5060808@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3EA07317@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41887 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab2K2L6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 06:58:14 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6205849bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 03:58:13 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA07317@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Avinash,

On 29.11.2012 06:24, Philip, Avinash wrote:
> On Wed, Nov 28, 2012 at 22:28:55, Daniel Mack wrote:
>> [Resending +devicetree-discuss, +Rob, +Grant]
>>
>>
>> This is a series of patches to support GPMC peripherals on OMAP boards.
>>
>> Depends on Linus' master +
>> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
> 
> Can you resend this series on top of linux_next?

The only branch these patches depend on is the
"omap-for-v3.8/cleanup-headers-gpmc" branch from omap_next. Are you
actually seeing any merge conflicts with my series? If so, which branch
are you referring to exactly?

> Some of the missing items I seen 
> 1. Of_node not populated in  omap_nand_platform_data structure.

Hmm - gpmc_probe_nand_child() from 4/4 adds

  gpmc_nand_data->of_node = child;

Do I miss anything?

> 2. Remove platform device creation from hwmod as GPMC DT is populating.
>    Currently GPMC device creaing from DT & HWMOD.

This is already addressed in cd00b0530 ("ARM: OMAP2+: gpmc: Fix kernel
BUG for DT boot mode") by Vaibhav Hiremath, which I got via Afzal's USB
branch:


https://gitorious.org/x0148406-public/linux-kernel/commit/cd00b053082a5cabbb1a35e072b0c044e17e8ec2/diffs

As that fix is on the way, I dropped my version which did the same thing.

> Also can you address how this patch series depends on
> mtd: nand: OMAP: ELM error correction support for BCH ecc

I have your ELM patches on top of mine, and they apply cleanly. But I
believe it shouldn't be an issue if you base mine on top of yours.

Let me know if you want me to rebase anything again. The best solution
probably if I make sure the series applies cleanly to whatever tree it
will be merged trough - but I don't know which that would be eventually.


Thanks for the continuing feedback,
Daniel


>>
>> The only supported peripheral for now is NAND, but other types would be
>> easy to add.
>>
>> Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
>> and Rob Herring:
>>
>>  - add "reg" and "ti,hwmod" properties to Documentation
>>  - use generic of_mtd functions and the property names defined by them,
>>    namely "nand-bus-width" and "nand-ecc-mode"
>>  - reduce the default register space size in the Documentation to 8K,
>>    as found in the hwmod code
>>  - switch to a DT layout based on ranges and address translation.
>>    Although this property is not currently looked at as long as the
>>    handling code still uses the runtime calculation methods, we now
>>    have these values in the bindings, eventually allowing us to
>>    switch the implementation with less pain.
>>
>> Version 3 includes fixes pointed out by Jon Hunter:
>>
>>  - better documentation of the 'ranges' property to describe the
>>    fact that it's representing the CS lines
>>  - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
>>  - drop interrupt-parent from example bindings
>>  - add of_node_put() at the end of the child iteration
>>
>> Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
>> details from Jon Hunter and Avinash, Philip:
>>
>>  - Add "num-cs" and "num-waitpins" properties, which will eventually
>>    be used to get rid of GPMC_CS_NUM
>>  - Better description of generic nand DT properties
>>  - Dropped patch 3/4 as an equivalent fix was already merged
>>  - Added ti,nand-ecc-use-elm property
>>
>> Version 5 with regards to Avinash, Philip and Peter Korsgaard:
>>
>>  - Re-add accidentially forgotten
>>    Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>  - Rename "software" ecc mode to "sw"
>>  - Initialize gpmc_nand_data->is_elm_used to 'true' rather than 1
>>  - Drop ti,nand-ecc-use-elm binding in favor of a new ecc mode
>>    named "bch8-am335xrbl-compatible"
>>  - Add two more patches for section mismatch fixups
>>
>> Daniel Mack (4):
>>   mtd: omap-nand: pass device_node in platform data
>>   ARM: OMAP: gpmc-nand: drop __init annotation
>>   ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
>>   ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
>>
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  76 +++++++++
>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  81 +++++++++
>>  arch/arm/mach-omap2/gpmc-nand.c                    |  15 +-
>>  arch/arm/mach-omap2/gpmc.c                         | 181 ++++++++++++++++++++-
>>  drivers/mtd/nand/omap2.c                           |   4 +-
>>  5 files changed, 348 insertions(+), 9 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>
>> -- 
>> 1.7.11.7
>>
>>
> 

