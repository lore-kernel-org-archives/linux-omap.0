From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: dra72-evm: Add NAND support
Date: Tue, 21 Oct 2014 12:16:39 -0500
Message-ID: <CAGo_u6q5SO74FYK61Zyx-oweiui=zatJzWjomVm7y6VES+a7Kg@mail.gmail.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
	<1413888080-2669-2-git-send-email-rogerq@ti.com>
	<54468D29.4070706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39058 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbaJURQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2014 13:16:40 -0400
In-Reply-To: <54468D29.4070706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: dt list <devicetree@vger.kernel.org>, george.cherian@ti.com, Sekhar Nori <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 21, 2014 at 11:43 AM, Nishanth Menon <nm@ti.com> wrote:
> Roger,
>
> On 10/21/2014 05:41 AM, Roger Quadros wrote:
>> DRA72-evm has a 256MB 16-bit wide NAND chip. Add
>> pinmux and NAND node.
>>
>> The NAND chips 'Chip select' and 'Write protect' can be
>> controlled using DIP Switch SW5. To use NAND,
>> the switch must be configured like so:
>>
>> SW5.1 (NAND_SELn) = ON (LOW)
>> SW5.9 (GPMC_WPN) = OFF (HIGH)
>
> Could we move this description to the dts as a comment? it would be
> little more easier to refer to than figuring it out from git log. I
> recollect trying to figure this out while attempting to test out NAND
> previously, never actually thought to check in git log. just a
> suggestion..

[...]

>> +&gpmc {
>> +     status = "okay";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&nand_default>;
>> +     ranges = <0 0 0 0x01000000>;    /* minimum GPMC partition = 16MB */
>> +     nand@0,0 {
>> +             /* To use NAND, DIP switch SW5 must be set like so:
>> +              * SW5.1 (NAND_SELn) = ON (LOW)
>> +              * SW5.9 (GPMC_WPN) = OFF (HIGH)
>> +              */

[...]

Uggh.. ignore my comment - I see you already did that.. my bad.. i missed it :(

Quickly trying to test this, I got the following:
"

[    1.840728] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    1.847290] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xca
[    1.854003] nand: Micron MT29F2G16ABAEAWP
[    1.858245] nand: 256MiB, SLC, page size: 2048, OOB size: 64
[    1.864227] omap2-nand omap2-nand.0: CONFIG_MTD_NAND_OMAP_BCH not enabled
[    1.871459] omap2-nand: probe of omap2-nand.0 failed with error -22
"

Full log: http://hastebin.com/ozugepemin.md

Does this depend on
http://marc.info/?l=linux-omap&m=141389532511600&w=2 to function? I
assume yes.

as well?

---
Regards,
Nishanth Menon
