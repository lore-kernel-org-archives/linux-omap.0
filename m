From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] Runtime detection of Si features
Date: Thu, 13 Aug 2009 22:07:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5A38B8C@dbde02.ent.ti.com>
References: <1250176701-23998-1-git-send-email-premi@ti.com>
 <877hx7g09i.fsf@deeprootsystems.com> <4A843FDE.5090209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbZHMQhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 12:37:38 -0400
In-Reply-To: <4A843FDE.5090209@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Nishanth Menon
>Sent: Thursday, August 13, 2009 11:31 AM
>To: Kevin Hilman
>Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
>Subject: Re: [PATCH] Runtime detection of Si features
>
>Kevin Hilman had written, on 08/13/2009 11:13 AM, the following:
>> Sanjeev Premi <premi@ti.com> writes:
>>
>>> The OMAP35x family has multiple variants differing
>>> in the HW features. This patch detects these features
>>> at runtime and prints information during the boot.
>>>
>>> Since most of the code seemed repetitive, macros
>>> have been used for readability.
>>>
>>> Signed-off-by: Sanjeev Premi <premi@ti.com>
>>
>> I like the feature-based approach.
>>
>> A couple questions though.  Is there a bit/register that reports the
>> collapsed powerdomains of the devices with modified PRCM?
>>
>> Also, how will other code query the features?  You're currently
>> exporting the omap_has_*() functions, but there are no prototypes.
>>
>> I think I'd rather see a static inline functions in <mach/cpu.h>
>> for checking features.  Comments to that end inlined below...
>Wonder if we can setup some sort of infrastructure for:
>a) features
>b) erratas
>linked to OMAP revs + even better w.r.t silicon module(SGX,I2c)
>revisions since at times they are used across multiple OMAPs?

We are hitting exactly this issue with I2C errata 1.153
Instead of basing the errata check on cpu_is...(), 
its more appropriate to base it on IP revision of I2C.


>
>--
>Regards,
>Nishanth Menon
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

