From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: linux-next: omap2plus_defconfig does not build
Date: Wed, 20 Oct 2010 00:03:11 +0530
Message-ID: <AANLkTikGkpx8Pd9uPSyQus2FibyU=zUjxFkwJnofFO9q@mail.gmail.com>
References: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com> <20101019171515.GB3038@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44996 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754014Ab0JSSdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 14:33:35 -0400
Received: by mail-wy0-f170.google.com with SMTP id 23so2836568wyf.1
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 11:33:34 -0700 (PDT)
In-Reply-To: <20101019171515.GB3038@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Leif Lindholm <leif.lindholm@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

On Tue, Oct 19, 2010 at 10:45 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Anand Gadiyar <gadiyar@ti.com> [101013 06:14]:
>> Building omap2plus_defconfig (which enables support for
>> OMAP2420/2430/OMAP3
>> and OMAP4 in one image), I get the following build error.
>>
>> =A0 CC =A0 =A0 =A0arch/arm/kernel/swp_emulate.o
>> /tmp/ccg979qz.s: Assembler messages:
>> /tmp/ccg979qz.s:343: Error: selected processor does not support ARM =
mode
>> `ldrexb r6,[r5]'
>> /tmp/ccg979qz.s:344: Error: selected processor does not support ARM =
mode
>> `strexb r1,r3,[r5]'
>> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
>> make: *** [arch/arm/kernel] Error 2
>>
>> I'm using CodeSourcery's 2010q1-202 toolchain based on gcc 4.4.1.
>>
>> I haven't been following the lists closely the last few days, so I'm=
 not
>> sure if this is a known issue. Just reporting it for now.
>
> This seems to be related to "ARM: Add SWP/SWPB emulation for ARMv7 pr=
ocessors (v5)"
> where SWP_EMULATE is selected by default. For the omap2plus_defconfig=
 in for-next
> we now have CPU_V6 and CPU_V7 set with SMP and SMP_ON_UP.
>

I had forgotten I'd reported this earlier. I reported the build break
again today, and Catalin provided this patch [1] which solves the
build issue.

- Anand

[1] http://marc.info/?t=3D128748412500003&r=3D1&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
