From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
Date: Fri, 17 Sep 2010 20:41:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329539FE3@dbde02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
 <874odpbodr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53053 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319Ab0IQPLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 11:11:54 -0400
In-Reply-To: <874odpbodr.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 16, 2010 10:46 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>Subject: Re: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>[...]
>>
>>>>>From: Paul Walmsley <paul@pwsan.com>
>>>>>
>>>>>The OPP layer code should be independent of the PMIC,
>>>>>introduce the TWL/TPS-specific code out to its own file.
>>>
>>> Hello Kevin,
>>>
>>> I have been using this code for a while now. I really do not think wee
>>> need a separate file for implementing the vsel to voltage in (uV) and
>>> vice versa formulas. Today only voltage layer is interested in these
>>> conversions. Voltage layer has a structure that can be populated with
>>> the information required from the PMIC. We only need to add two more
>>> function pointers to this structure. This info can then be passed from
>>> the actual PMIC driver file. This will make it much more simpler for
>>> OMAP4 where we have different formulas between different revisions of
>>> PMIC. Also in the omap voltage code we will no longer have to hard
>>> code omap_twl_vsel_to_uv and omap_twl_uv_to_vsel.
>>
>>Feel free to post an RFC series for what you're proposing.
>>
>>IMHO, even the voltage layer should not care about these conversions.
>>The voltage layer should care about voltages, and the PMIC layer should
>>handle these conversions.  IOW, this stuff is best abstracted in the
>>PMIC code, or board- or SoC-specific hooks that can be registered with
>>the PMIC.
>>
>>> So please consider dropping this patch from this series.
>>
>>If you pick this up as part of your voltage series (or more likely as a
>>pre-requisite of your voltage series) we can surely drop it from this
>>series, at it doesn't really belong with the OPP series.

Hello Kevin/Nishant

My suggestion is introduce two new APIs in drivers/twl-core.c. Then once voltage
layer support is added call into an API provided by voltage layer to register two APIs.
If both Nishant and you are ok with this I will post this change as par of my voltage
and smartreflex series.

Regards
Thara

