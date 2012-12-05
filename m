From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v7 0/5] OMAP GPMC DT bindings
Date: Wed, 05 Dec 2012 20:24:57 +0100
Message-ID: <50BF9F89.1000407@gmail.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com> <50BF9EF8.3060507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45062 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab2LETZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 14:25:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2362779bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Dec 2012 11:25:06 -0800 (PST)
In-Reply-To: <50BF9EF8.3060507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-omap@vger.kernel.org, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, devicetree-discuss@lists.ozlabs.org

On 05.12.2012 20:22, Jon Hunter wrote:
> 
> On 12/05/2012 01:09 PM, Daniel Mack wrote:
>> This is a series of patches to support GPMC peripherals on OMAP boards.
>>
>> Grant, Rob, could you have a look and give your Acked-by if
>> appropriate?
>>
>>
>> Many thanks again,
>> Daniel
>>
>>
>> Tested on Linus' master +
>> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
>>
>> Generated from linux-next as of today, resolving one trivial include
>> file rebase conflict.
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
>> Version 6:
>>
>>  - Dropped "bch8-am335xrbl-compatible" mode again. As discussed with
>>    Avinash, the ELM issue will be solved subsequently in s separate
>>    series.
>>  - re-added a patch to bail out of automatic GPMC instanciation in
>>    case of DT boot.
>>  - re-added the "of_node" addition in mtd_nand_omap2.h in 2/5
>>
>> Version 7: comments from Jon Hunter, all affecting the documentation:
>>
>>  - add num-wait pins properties as they are marked 'required'
>>  - make reg sizes consistent
>>  - AM335x only has 2 wait-pins
>>
>> Again, many thanks to everybody, in particular Avinash, for the long
>> disussion about how to the these details right in the first place.
>>
>>
>> Daniel
>>
>> Daniel Mack (5):
>>   ARM: OMAP: gpmc: don't create devices from initcall on DT
>>   mtd: omap-nand: pass device_node in platform data
>>   ARM: OMAP: gpmc-nand: drop __init annotation
>>   ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
> 
> Do you still need patch #4 now? Can't we drop this?
> 
> May be worth just including what is required for linux-next as this is
> 3.9 material.

Well, yes, otherwise the driver init will bail of course, so I need it
locally.

Feel free to drop it when that's not needed at the time of merging the
series, but for now I resubmitted everything you need to test and use
these patches :)


Daniel

