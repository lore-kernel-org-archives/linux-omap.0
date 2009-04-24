From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 24 Apr 2009 15:50:30 -0700
Message-ID: <874owdy8cp.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com>
	<87d4b4zc8e.fsf@deeprootsystems.com> <49F16044.6000603@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:51937 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbZDXWuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 18:50:32 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1164936wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2009 15:50:31 -0700 (PDT)
In-Reply-To: <49F16044.6000603@nokia.com> (Roger Quadros's message of "Fri\, 24 Apr 2009 09\:46\:28 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> ext Kevin Hilman wrote:
[...]
>>
>> Rajendra,
>>
>> This series seems to boot on SDP and Beagle but I recetly tried on
>> RX51 and it hangs in omap3_sr_init().
>>
>> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
>> PRM write to the PRM_VP1_VLIMITTO register:
>>
>> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
>> 					PRM_VP1_VLIMITTO_VDDMIN |
>> 					PRM_VP1_VLIMITTO_TIMEOUT,
>> 					OMAP3430_GR_MOD,
>> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
>>
>>
>> Should these min/max/timeout values be board specific?
>>

[...]

>
> It runs on rx51 if we set CONFIG_OMAP_PM_SRF instead of CONFIG_OMAP_PM_NOOP.
>
> Should Smartreflex option be dependent or independent of the
> CONFIG_OMAP_PM_??? setting?
>

I see the same thing on SDP as well as RX51.

It looks like the new SR code assumes a range of OPPs, but when
OMAP_PM_NONE is enabled, the omap_pm_vddX_get_opp() calls always
return zero.

In the mpu_opps array, the first entry is all zeros, resulting
in a zero VSEL which is then used to (re)program the VP.

The SR code should probably be a bit smarter about checking for valid
values.

Kevin



