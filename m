From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 29 Nov 2012 16:07:20 +0100
Message-ID: <50B77A28.8080608@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com> <1354121939-11246-5-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com> <50B75806.8030501@gmail.com> <518397C60809E147AF5323E0420B992E3EA0BB4B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54760 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab2K2PHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 10:07:30 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6317479bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 07:07:29 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA0BB4B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 29.11.2012 15:59, Philip, Avinash wrote:
> On Thu, Nov 29, 2012 at 18:11:42, Daniel Mack wrote:
>> On 29.11.2012 13:36, Philip, Avinash wrote:
>>> On Wed, Nov 28, 2012 at 22:28:59, Daniel Mack wrote:
>>> [...]
>>>> +	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
>>>> +		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
>>>> +			if (!strcasecmp(s, nand_ecc_opts[val])) {
>>>> +				gpmc_nand_data->ecc_opt = val;
>>>> +				break;
>>>> +			}
>>>> +
>>>> +		/*
>>>> +		 *  AM335x RBL compatibility mode - dependns on runtime
>>>> +		 * detection of the error location module.
>>>> +		 */
>>>> +		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
>>>> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
>>>> +			gpmc_nand_data->is_elm_used = true;
>>>
>>> Remove is_elm_used from struct omap_nand_platform_data. Now this data
>>> populated as part of run time detection of elm module. So please remove
>>> The usage of is_elm_used;
>>
>> So why do we need "bch8-am335xrbl-compatible" as special case then?
>>
>> I thought the whole idea here is to tell the driver we want bch8 *and*
>> the usage of the elm, instead of falling back to the (incompatible)
>> software mode? If I remove that assignment, "bch8-am335xrbl-compatible"
>> is the same than "bch8".
>>
> 
> Here we have different problems present. 
> 1. GPMC-NAND DT binding support.
> 2. Compatible ECC layout between kernel, boot loader.
> 3. Support for hardware accelerator, i.e ELM for error correction.
> 
> So priority should go for GPMC DT binding support. 
> Can you please proceed with GPMC-NAND DT bindings without considering
> ELM so that driver features existing can be obtained with DT.
> 
> I will take care of ECC layout (or RBL) compatibility along with ELM
> series. I will make ELM series on top of your changes. This way we can
> avoid circular dependency

Ok, fair enough. I'll drop "bch8-am335xrbl-compatible" from the list
again and only care for those that are present in the enum.

Before I send the patches again, could you quickly state which
repository they will go through? I'll make sure there are no conflicts
when applying.

>> Which detail am I missing? :)
> 
> I think what you need is NAND ECC layout to be common across Kernel and
> boot loader. Strictly speaking ELM is not a necessity for it. The common
> layout can be obtained even without presence of ELM, ELM is only a hardware
> accelerator for error correction. If ELM is not used, we can rely on software
> error correction, at least theoretically. But the way software error correction
> is handled currently in omap nand driver will not help us as ecc layout assumed
> is different.

Yes, understood, hence I need some workaround for now, which I can
happily keep in my local branch.


Thanks,
Daniel

