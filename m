From: Colin Cross <ccross@google.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 16:37:08 -0700
Message-ID: <CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:47168 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab1F1XhM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 19:37:12 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p5SNbA7v015637
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:37:10 -0700
Received: from ywp17 (ywp17.prod.google.com [10.192.16.17])
	by wpaz1.hot.corp.google.com with ESMTP id p5SNb9Co020020
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:37:09 -0700
Received: by ywp17 with SMTP id 17so415822ywp.15
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:37:09 -0700 (PDT)
In-Reply-To: <20110628231711.GC23312@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Jun 28, 2011 at 4:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 28, 2011 at 03:58:57PM -0700, Colin Cross wrote:
>> On Tue, Jun 28, 2011 at 3:55 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Jun 28, 2011 at 03:29:57PM -0700, Colin Cross wrote:
>> >> Can't this rewrite the loops_per_jiffy for the other CPU while it=
 is
>> >> in a udelay? =A0If it has already calculated the number of loops
>> >> necessary, and the CPU frequency increases, it could end up retur=
ning
>> >> too early from udelay.
>> >
>> > udelay uses the global loops_per_jiffy.
>> >
>>
>> The problem is still the same - loops_per_jiffy applies to both CPUs=
,
>> and the frequency of the other CPU cannot be changed if it is in a
>> udelay.
>
> If you have a SMP system where both CPUs scale together then you will
> get both CPUs being impacted, which may result in udelay() terminatin=
g
> well early or taking much longer than was originally intended.
>
> That's rather unavoidable with software timing loops - we could add a
> rw spinlock around udelay, but that would require interrupts to be
> disabled and that wouldn't be nice in general to have every udelay
> running with IRQs off.
>
> That's why people have proposed hardware-timer based delay loops -
> these screw up the bogomips value (it no longer refers to the CPU
> but to the timer used for the delays) and the code proposed thus far
> probably has a severe negative impact on ARMs running at low clock
> rates (the calculation cost of the number of loops to run becomes
> significant for CPUs below 100MHz for short delays with the existing
> optimized assembler, so moving it into C and introducing function
> pointers will only make it worse.)
>

I don't think it affects bogomips - loops_per_jiffy can still be
calibrated and updated by cpufreq, udelay just wont use them.

If the pointer dereference is done at the udelay() call to allow each
platform to override udelay, slow platforms can continue to use the
original optimized assembly with only a few extra instructions
overhead on entry.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
