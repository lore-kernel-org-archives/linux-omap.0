From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 10/13 v3] OMAP: GPIO: Add gpio dev_attr and correct clks
 in OMAP4 hwmod struct
Date: Tue, 22 Jun 2010 19:00:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5C93075@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
	<1276614348-5201-2-git-send-email-charu@ti.com>
	<1276614348-5201-3-git-send-email-charu@ti.com>
	<1276614348-5201-4-git-send-email-charu@ti.com>
	<1276614348-5201-5-git-send-email-charu@ti.com>
	<1276614348-5201-6-git-send-email-charu@ti.com>
	<1276614348-5201-7-git-send-email-charu@ti.com>
	<1276614348-5201-8-git-send-email-charu@ti.com>
	<1276614348-5201-9-git-send-email-charu@ti.com>
	<1276614348-5201-10-git-send-email-charu@ti.com>
	<1276614348-5201-11-git-send-email-charu@ti.com>	<4C17ACE8.6000805@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B62A@dbde02.ent.ti.com>
	<4C1891F7.40101@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B3@dbde02.ent.ti.com>
 <87ocf9mwzg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53391 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab0FVNbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 09:31:16 -0400
In-Reply-To: <87ocf9mwzg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, June 17, 2010 10:13 PM
> To: Varadarajan, Charulatha
> Cc: Cousson, Benoit; david-b@pacbell.net; 
> broonie@opensource.wolfsonmicro.com; 
> akpm@linux-foundation.org; linux-omap@vger.kernel.org; 
> paul@pwsan.com; Nayak, Rajendra; tony@atomide.com; Basak, Partha
> Subject: Re: [PATCH 10/13 v3] OMAP: GPIO: Add gpio dev_attr 
> and correct clks in OMAP4 hwmod struct
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> [...]
> 
> >> 
> >> So please, don't do that.
> >> 
> >> BTW, you didn't answer the first answer, do you really need that?
> >> 
> > It is used in save/restore context which would be called
> > from sram_idle path.
> 
> Cleaning this up should be considered instead of keeping around the
> bank count.
> 
> The save/restore should be done per-bank whenever the bank usage count
> goes to zero (or changes from zero.)

When a GPIO is acquired in a particular gpio bank, the gpio bank can still
go to idle if it is called by omap_sram_idle(). In such a case, restore
context will be called even when bank count is not 0.

> 
> If you don't want to address that cleanup in this series, add it to
> the TODO list for the cleanups and use the current variable, but it's
> value should be set when iterating over the number of hwmods as
> suggested by Benoit.

Okay. Will add these changes in my next version of patchset. 

> 
> Kevin
> 

>>>>>
>>>>>> +	.gpio_bank_bits = 32,
>>>>>> +	.dbck_flag = true,
>>>>>> +};
>>>>>
>>>>> Since this structure is the same than OMAP3, you should maybe consider
>>>>> sharing it.
>>>>
>>>> They are in different _data.c files. I feel that it will be good if they are
>>> kept decoupled as we need not have to mix up different SoC data. Here it's only a
>>> coincidence that OMAP3 and OMAP4 have same data
>>>
>>> No it is not a coincidence, it is because we are re-using the same IP
>>> implementation. In that case, it is not a big deal, but you should try
>>> to reuse as most as you can already existing data.
>>
>> They are in two different omap_hwmod_xxxx_data.c files. Is there a way to share this data?

> You can use omap_hwmod_common_data.c if you want.

It is common only for OMAP3/4 and not for OMAP2. But, omap_hwmod_common_data.c is common
for all OMAP2PLUS. Hence will maintain dev_attr for OMAP3&4 in their respective
hwmod database files.

> Benoit