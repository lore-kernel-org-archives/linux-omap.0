From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Tue, 28 Apr 2009 11:32:03 +0300
Message-ID: <49F6BF03.8060504@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8BEC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19953 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZD1Icv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 04:32:51 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8BEC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nayak, Rajendra" <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

ext Nayak, Rajendra wrote:
>  
> 
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Saturday, April 25, 2009 4:21 AM
>> To: Roger Quadros
>> Cc: Nayak, Rajendra; linux-omap
>> Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
>>
>> Roger Quadros <ext-roger.quadros@nokia.com> writes:
>>
>>> ext Kevin Hilman wrote:
>> [...]
>>>> Rajendra,
>>>>
>>>> This series seems to boot on SDP and Beagle but I recetly tried on
>>>> RX51 and it hangs in omap3_sr_init().
>>>>
>>>> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
>>>> PRM write to the PRM_VP1_VLIMITTO register:
>>>>
>>>> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
>>>> 					PRM_VP1_VLIMITTO_VDDMIN |
>>>> 					PRM_VP1_VLIMITTO_TIMEOUT,
>>>> 					OMAP3430_GR_MOD,
>>>> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
>>>>
>>>>
>>>> Should these min/max/timeout values be board specific?
>>>>
>> [...]
>>
>>> It runs on rx51 if we set CONFIG_OMAP_PM_SRF instead of 
>> CONFIG_OMAP_PM_NOOP.
>>> Should Smartreflex option be dependent or independent of the
>>> CONFIG_OMAP_PM_??? setting?
>>>
>> I see the same thing on SDP as well as RX51.
>>
>> It looks like the new SR code assumes a range of OPPs, but when
>> OMAP_PM_NONE is enabled, the omap_pm_vddX_get_opp() calls always
>> return zero.
>>
>> In the mpu_opps array, the first entry is all zeros, resulting
>> in a zero VSEL which is then used to (re)program the VP.
>>
>> The SR code should probably be a bit smarter about checking for valid
>> values.
>>
> 
> Kevin,
> 
> I'll send in a patch to fix that.
> 
> thanks,
> Rajendra
> 
>>
>>
>>

I think the the X_get_opp() and X_get_freq() calls should be returning
sane values irrespective of PM layer (i.e. OMAP_PM_NOOP or OMAP_PM_NONE).
I have a patchset which does this with a little help from resource.c to get
the current OPP/frequency.
This fixes boot on RX51 for both PM_NOOP and PM_NONE with SMARTREFLEX enabled.

I just want to know if this is the right way to do. I think it would be because
Smartreflex or any other future driver will not have to worry about which PM 
layer is selected.

I will send my patchset as an RFC.

regards,
-roger
