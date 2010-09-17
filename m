From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
Date: Fri, 17 Sep 2010 10:03:02 -0500
Message-ID: <4C938326.6080400@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com> <1284587799-9637-3-git-send-email-khilman@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com> <4C920A49.5010105@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032944262A@dbde02.ent.ti.com> <4C92246C.3010404@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0329539FDF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43249 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab0IQPDF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 11:03:05 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0329539FDF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Gopinath, Thara had written, on 09/17/2010 09:57 AM, the following:
[..]
>>>>>>>>> From: Paul Walmsley <paul@pwsan.com>
>>>>>>>>>
>>>>>>>>> The OPP layer code should be independent of the PMIC,
>>>>>>>>> introduce the TWL/TPS-specific code out to its own file.
>>>>>>>
>>>>>>> I have been using this code for a while now. I really do not think wee need a separate
>>>>>>> file for implementing the vsel to voltage in (uV) and vice versa formulas. Today only voltage
>>>>>> This split introduces a PMIC level abstraction already. Do you have a
>>>>>> suggestion which file it should go to? It is definitely not part of
>>>>>> opp.c, not part of other existing twl files as well. the job of this
>>>>>> file was to introduce conversion routines which can be used by any layer
>>>>>> (voltage layer if need be - it used to be srf and smartreflex before)..
>>>>>> in fact one of your voltage layer patches introduces capability for 6030
>>>>>> as well
>>>>>> http://marc.info/?l=linux-omap&m=128213020927919&w=2
>>>> Yes one of my patches has introduces this coz I had no other way
>>>> to add OMAP4 support. But I still do not understand why cant these
>>>> APIs be implemented in twl-core.c or twl4030-power.c?
>>> Why there? Twl power does regulator operations not conversion
>>> operations. core is not the place either as it is function independent.
> 
> Why  do you say core is not the place. For me core is exactly
> the place. It is the PMIC driver file.
See [1] - they are all generic without a specific domain implementation. 
if we are so touchy about the location we want these api implementation, 
I guess core might be a compromise enough.. personally even though I 
believe core should remain specific functionality independent, I dont 
think I have very strong opinions about adding helpers there.. i 
would'nt put registration there though.. That should be in board files..

[1] 
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=drivers/mfd/twl4030-core.c;h=769b34bd48e445880ac0920423d9b73eabaf4cb7;hb=HEAD

-- 
Regards,
Nishanth Menon
