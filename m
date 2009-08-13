From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Runtime detection of Si features
Date: Thu, 13 Aug 2009 11:01:44 -0700
Message-ID: <87iqgregon.fsf@deeprootsystems.com>
References: <1250176701-23998-1-git-send-email-premi@ti.com>
	<877hx7g09i.fsf@deeprootsystems.com> <4A843FDE.5090209@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F5A38B8C@dbde02.ent.ti.com>
	<873a7vfz05.fsf@deeprootsystems.com> <4A84429D.4050600@ti.com>
	<4A84544A.7030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:56684 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZHMSBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 14:01:46 -0400
Received: by wf-out-1314.google.com with SMTP id 26so293743wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 11:01:47 -0700 (PDT)
In-Reply-To: <4A84544A.7030808@ti.com> (Nishanth Menon's message of "Thu\, 13 Aug 2009 12\:58\:34 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Nishanth Menon had written, on 08/13/2009 11:43 AM, the following:
>> Kevin Hilman had written, on 08/13/2009 11:40 AM, the following:
>>> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>>>
>>>>> -----Original Message-----
>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>>>> Sent: Thursday, August 13, 2009 11:31 AM
>>>>>>> Since most of the code seemed repetitive, macros
>>>>>>> have been used for readability.
>>>>>>>
>>>>>>> Signed-off-by: Sanjeev Premi <premi@ti.com>
>>>>>> I like the feature-based approach.
>>>>>>
>>>>>> A couple questions though.  Is there a bit/register that reports the
>>>>>> collapsed powerdomains of the devices with modified PRCM?
>>>>>>
>>>>>> Also, how will other code query the features?  You're currently
>>>>>> exporting the omap_has_*() functions, but there are no prototypes.
>>>>>>
>>>>>> I think I'd rather see a static inline functions in <mach/cpu.h>
>>>>>> for checking features.  Comments to that end inlined below...
>>>>> Wonder if we can setup some sort of infrastructure for:
>>>>> a) features
>>>>> b) erratas
>>>>> linked to OMAP revs + even better w.r.t silicon module(SGX,I2c)
>>>>> revisions since at times they are used across multiple OMAPs?
>>>> We are hitting exactly this issue with I2C errata 1.153
>>>> Instead of basing the errata check on cpu_is...(), its more
>>>> appropriate to base it on IP revision of I2C.
>>> Shouldn't the IP revision of I2C be avaialble in an I2C revision
>>> register an be used in the driver instead of cpu_is*?
>> what I was proposing is a much more generic infrastructure which i2c
>> among other modules can use. Getting IP revision is already
>> available in the specific IP modules REVISION registers - we might
>> want to standardize how drivers handle revision based feature/errata
>> set to ensure that they would have an optimal way to handle the
>> same.. just my 2 cents..
>>
> Thinking of this a little more:
> driver's smart handling aside, having a sysfs entry to dump the
> features and erratas for each of the modules used is so much nice to
> have.. sigh.. just wondering if anyone has ideas how feasible this
> might be..

$SUBJECT patch will dump all the chip features during boot, and it
shouldn't be much work too add this to /proc/cpuinfo either.

The errata are another story and should be left to another patch IMHO
since Sanjeev is just tring to get base 35xx support enabled for now.

Kevin

