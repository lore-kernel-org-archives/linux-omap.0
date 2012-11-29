From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 29 Nov 2012 13:41:42 +0100
Message-ID: <50B75806.8030501@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com> <1354121939-11246-5-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46767 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab2K2Mls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 07:41:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6230488bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 04:41:46 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA0B986@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 29.11.2012 13:36, Philip, Avinash wrote:
> On Wed, Nov 28, 2012 at 22:28:59, Daniel Mack wrote:
> [...]
>> +	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
>> +		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
>> +			if (!strcasecmp(s, nand_ecc_opts[val])) {
>> +				gpmc_nand_data->ecc_opt = val;
>> +				break;
>> +			}
>> +
>> +		/*
>> +		 *  AM335x RBL compatibility mode - dependns on runtime
>> +		 * detection of the error location module.
>> +		 */
>> +		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
>> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
>> +			gpmc_nand_data->is_elm_used = true;
> 
> Remove is_elm_used from struct omap_nand_platform_data. Now this data
> populated as part of run time detection of elm module. So please remove
> The usage of is_elm_used;

So why do we need "bch8-am335xrbl-compatible" as special case then?

I thought the whole idea here is to tell the driver we want bch8 *and*
the usage of the elm, instead of falling back to the (incompatible)
software mode? If I remove that assignment, "bch8-am335xrbl-compatible"
is the same than "bch8".

Which detail am I missing? :)


Daniel

