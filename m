From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Runtime detection of Si features
Date: Thu, 13 Aug 2009 09:40:42 -0700
Message-ID: <873a7vfz05.fsf@deeprootsystems.com>
References: <1250176701-23998-1-git-send-email-premi@ti.com>
	<877hx7g09i.fsf@deeprootsystems.com> <4A843FDE.5090209@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F5A38B8C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:48586 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbZHMQkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 12:40:43 -0400
Received: by wf-out-1314.google.com with SMTP id 26so280385wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 09:40:44 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5A38B8C@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 13 Aug 2009 22\:07\:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>Nishanth Menon
>>Sent: Thursday, August 13, 2009 11:31 AM
>>To: Kevin Hilman
>>Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
>>Subject: Re: [PATCH] Runtime detection of Si features
>>
>>Kevin Hilman had written, on 08/13/2009 11:13 AM, the following:
>>> Sanjeev Premi <premi@ti.com> writes:
>>>
>>>> The OMAP35x family has multiple variants differing
>>>> in the HW features. This patch detects these features
>>>> at runtime and prints information during the boot.
>>>>
>>>> Since most of the code seemed repetitive, macros
>>>> have been used for readability.
>>>>
>>>> Signed-off-by: Sanjeev Premi <premi@ti.com>
>>>
>>> I like the feature-based approach.
>>>
>>> A couple questions though.  Is there a bit/register that reports the
>>> collapsed powerdomains of the devices with modified PRCM?
>>>
>>> Also, how will other code query the features?  You're currently
>>> exporting the omap_has_*() functions, but there are no prototypes.
>>>
>>> I think I'd rather see a static inline functions in <mach/cpu.h>
>>> for checking features.  Comments to that end inlined below...
>>Wonder if we can setup some sort of infrastructure for:
>>a) features
>>b) erratas
>>linked to OMAP revs + even better w.r.t silicon module(SGX,I2c)
>>revisions since at times they are used across multiple OMAPs?
>
> We are hitting exactly this issue with I2C errata 1.153
> Instead of basing the errata check on cpu_is...(), 
> its more appropriate to base it on IP revision of I2C.

Shouldn't the IP revision of I2C be avaialble in an I2C revision
register an be used in the driver instead of cpu_is*?

Kevin
