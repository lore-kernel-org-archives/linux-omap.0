From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 0/3] OMAP3: PM: Make PRM setup times and CPUidle
 latencies/threshold board specific
Date: Wed, 14 Oct 2009 17:40:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A46CCF7@dbde02.ent.ti.com>
References: <87bpkbjdka.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58030 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbZJNMLY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 08:11:24 -0400
In-Reply-To: <87bpkbjdka.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: Wednesday, October 14, 2009 1:02 AM
>To: Nayak, Rajendra
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 0/3] OMAP3: PM: Make PRM setup times and 
>CPUidle latencies/threshold board specific
>
>"Nayak, Rajendra" <rnayak@ti.com> writes:
>
>> The setup times to be programmed in the PRM module on OMAP (for
>> clksetup, voltsetup etc) are board specific. They depend heavily on
>> the PMIC used and even on different boards with the same PMIC, they
>> vary based on the sleep/wake sequence used, system clock speed et
>> al.
>>
>> The CPUidle latencies and hence thresholds (derived from latencies
>> and Power consumption numbers) and very much dependent on these
>> setup values and hence also need to be board specific.
>>
>> This patchset makes it possible for the PRM setup times and the
>> CPUidle latencies/threshold numbers to be configured from board
>> files, and some default values are used if nothing gets passed from
>> board files.
>>
>> Only the 3430SDP board file is currently been modifed to pass these
>> values and the rest of the 3430 based board's still pass NULL and
>> hence use the default values defined.
>
>Hi Rajendra,
>
>Thanks for making these changes.  I'm very much for the approach
>you've taken in these patches to make these more configurable.
>
>One other comment that would require one more spin:
>
>Since we may be moving the OPP tables from board code to SoC 
>common code,
>let's separate the rate tables from the VC and cpudle parameters.

Ok, I'll drop those changes from my patch-set.

>
>How about an optional omap3_pm_init_vc() for the setup times. and
>omap3_pm_init_cpuidle() for the CPUidle values.  This way only the
>board files that don't want the defaults have to call them.
>
>The other benefit of having optional calls is that we don't have to
>keep touching every single board file to make these kinds of changes.

Yes, makes sense. I will repost the updated patchset.

>
>Thanks,
>
>Kevin
>
>
>
>