From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 05 Mar 2013 16:20:22 +0000
Message-ID: <51361B46.507@mimc.co.uk>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:37087 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752404Ab3CEQUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 11:20:24 -0500
In-Reply-To: <51360562.20309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

On 05/03/13 14:46, Jon Hunter wrote:
> 
> On 03/05/2013 08:34 AM, Mark Jackson wrote:
>> On 26/02/13 17:30, Jon Hunter wrote:
>>> NOR flash is not currently supported when booting with device-tree
>>> on OMAP2+ devices. Add support to detect and configure NOR devices
>>> when booting with device-tree.
>>>
>>> Add documentation for the TI GPMC NOR binding.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>
>> I'm trying to test this series, and am unable get my NOR device recognised.
>>
>> If I remove all reference to NOR (and keep only my NAND device definition), then
>> everything seems to boot fine (so I'm assuming I've got at least the basics of
>> the patch set working).
>>
>> My GPMC tree looks like this:-

<snip>

>> 	nor@1,0 {
>> 		reg = <3 0x00000000 0x04000000>;
>> 		compatible = "cfi-flash";
>> 		linux,mtd-name = "spansion,s29gl064n90t";
>> 		bank-width = <2>;
>>
>> 		gpmc,device-width = <1>;
> 
> Only bank-width should be necessary for NOR (per the binding
> documentation). However, if you do specify both, then they should match.
> Do you have two 8-bits devices? If so may be I need to update the
> documentation to make it clear this is the total width of all devices
> for a given chip-select.

No ... that was wrong, so I've fixed that.

<snip>

>> Booting with this NOR device produces the following oops:-
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 3.9.0-rc1-12191-ga00d6d1-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #33 Tue Mar 5 13:08:25 GMT 2013
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d

<snip>

>> [    0.236730] omap-gpmc 50000000.gpmc: could not find pctldev for node /pinmux@44e10800/gpmc_pins, deferring probe
>> [    0.236781] platform 50000000.gpmc: Driver omap-gpmc requests probe deferral
> 
> This look like your problem. I would figure out why this is failing and
> try again.

Hmmmm ... I get this even when I've no NOR device defined and the board boots up fine.

But I can see in physmap_of.c that the device gets registered without any call to
devm_pinctrl_get_select_default() and hence no probe deferring takes place is the
pinctrl device hasn't yet been started (which it hasn't).

Does probe deferral need adding to physmap_of.c, or should the pinctrl device really
be registered sooner ?

Cheers
Mark J.
