From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 15 Nov 2012 08:26:52 +0800
Message-ID: <50A436CC.8040502@gmail.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com> <1351869956-2787-5-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com> <5097B7EE.3000508@gmail.com> <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com> <509A2E75.5060307@gmail.com> <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com> <509EA360.2050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46705 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab2KOA1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 19:27:12 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so412918dak.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 16:27:11 -0800 (PST)
In-Reply-To: <509EA360.2050504@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11.11.2012 02:56, Daniel Mack wrote:
> On 07.11.2012 16:37, Philip, Avinash wrote:
>> On Wed, Nov 07, 2012 at 15:18:37, Daniel Mack wrote:
>>> On 05.11.2012 14:29, Philip, Avinash wrote:
>>>> On Mon, Nov 05, 2012 at 18:28:22, Daniel Mack wrote:
>>>>> On 05.11.2012 12:03, Philip, Avinash wrote:
>>>>>> On Fri, Nov 02, 2012 at 20:55:56, Daniel Mack wrote:
>>>>>>> This patch adds basic DT bindings for OMAP GPMC.
>>>>>>>
>>>>>>> The actual peripherals are instanciated from child nodes within the GPMC
>>>>>>> node, and the only type of device that is currently supported is NAND.
>>>>>>>
>>>>>>> Code was added to parse the generic GPMC timing parameters and some
>>>>>>> documentation with examples on how to use them.
>>>>>>>
>>>>>>> Successfully tested on an AM33xx board.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>>>> [...]
>>>>>>> +
>>>>>>> +		nand@0,0 {
>>>>>>> +			reg = <0 0 0>; /* CS0, offset 0 */
>>>>>>> +			nand-bus-width = <16>;
>>>>>>> +			nand-ecc-mode = "none";
>>>>>>> +
>>>>>>> +			gpmc,sync-clk = <0>;
>>>>>>> +			gpmc,cs-on = <0>;
>>>>>>> +			gpmc,cs-rd-off = <36>;
>>>>>>> +			gpmc,cs-wr-off = <36>;
>>>>>>> +			gpmc,adv-on = <6>;
>>>>>>> +			gpmc,adv-rd-off = <24>;
>>>>>>> +			gpmc,adv-wr-off = <36>;
>>>>>>> +			gpmc,we-off = <30>;
>>>>>>> +			gpmc,oe-off = <48>;
>>>>>>> +			gpmc,access = <54>;
>>>>>>> +			gpmc,rd-cycle = <72>;
>>>>>>> +			gpmc,wr-cycle = <72>;
>>>>>>> +			gpmc,wr-access = <30>;
>>>>>>> +			gpmc,wr-data-mux-bus = <0>;
>>>>>>> +
>>>>>>> +			#address-cells = <1>;
>>>>>>> +			#size-cells = <1>;
>>>>>>> +
>>>>>>
>>>>>> Can you take the timings (for example) from arago tree. The timings is tested in am335x-evm
>>>>>> So the timings can be directly used to populate GPMC timings. Timings can found at
>>>>>>
>>>>>> http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;
>>>>>> h=66bfbd2c5b35dc81edce0c24843c476161ab5978;hp=370630359cb8db711cf0941cd2a242e28ccfb61e
>>>>>>
>>>>>> [...]
>>>>>>> +static int gpmc_probe_dt(struct platform_device *pdev)
>>>>>>
>>>>>> Can you take care of the following section mismatch.
>>>>>> WARNING: vmlinux.o(.text+0x1e2d0): Section mismatch in reference
>>>>>> from the function gpmc_probe_dt() to the function .init.text:gpmc_nand_init().
>>>>>
>>>>> Sore, both fixed for v4.
>>>>>
>>>>>> [...]
>>>>>>> +
>>>>>>> +		val = of_get_nand_ecc_mode(child);
>>>>>>> +		if (val >= 0)
>>>>>>> +			gpmc_nand_data->ecc_opt = val;
>>>>>>
>>>>>> This will fail for BCH. Index of "soft_bch" is 5 & also don't have selection
>>>>>> option between for BCH4 & BCH8 also.
>>>>>> Can you use the of_property_read_u32 (as done early) to pass the ecc selection
>>>>>> from dt file. This will help selection of BCH4 & BCH8 ecc options.
>>>>>
>>>>> Hmm. Shouldn't we rather teach of_get_nand_ecc_mode() that two modes and
>>>>> bring the enum in sync?
>>>>
>>>> ecc_opt is for selecting different ecc layout and not for selecting ecc mode.
>>>>
>>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
>>>> 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE
>>>> 	OMAP_ECC_BCH4_CODE_HW
>>>> 	OMAP_ECC_BCH8_CODE_HW
>>>>
>>>> So selection of ecc layout data should come from DT not ecc mode.
>>>
>>> Ok, I see. I would still like to set them by string rather than magic
>>> numbers that map to enum entries. Valid values would be "none", "hw",
>>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
>>
>> Ok, that's nice. Better use ecc_opt instead of ecc_mode.
> 
> I did some more extensive tests that include reading the same nand pages
> from both U-Boot and the kernel with BCH8 ECC, and it turns out that
> ->is_elm_used needs to be set in the pdata in order to make this work.
> 
> So the question is whether we actually want to have a DT property for
> that or just always enable that bit in case a hardware supported ecc
> mode is selected. Any opinion on this?
> 
> That's the last topic before I'm clear to send off v4.

Any opionion on this, anyone?


Thanks,
Daniel

