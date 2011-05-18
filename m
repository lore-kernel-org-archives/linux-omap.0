From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] ARM: fix mistaken dependency for CPU_HAS_PMU
Date: Wed, 18 May 2011 17:31:30 +0800
Message-ID: <BANLkTinkZZwPG6S2goLYhuNV8JcVB-xsFw@mail.gmail.com>
References: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
	<4785097973995347565@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50165 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1ERJbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 05:31:31 -0400
Received: by yxs7 with SMTP id 7so466595yxs.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 02:31:30 -0700 (PDT)
In-Reply-To: <4785097973995347565@unknownmsgid>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

2011/5/18 Will Deacon <will.deacon@arm.com>:
> Hi,
>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> Obviously it is mistake for CPU_HAS_PMU to depend on
>> (!ARCH_OMAP3 || OMAP3_EMU).
>
> It's not that obvious!

No, on ubuntu 11.04, default config options enables ARCH_OMAP3
and ARCH_OMAP4, and disable OMAP3_EMU, so cause pmu.o
can't be built in kernel.

pmu.o is just a platform driver for pmu device, so we should always
allow it to be built into kernel no matter there are pmu devices or
not, so we can support multiple boards with one same image.

>
>> No mattery it is omap3 or not, we can build pmu.o into
>> kernel safely. In fact, arm-v7 of omap3 has pmu inside
>> also.
>
> Yes, but the PMU on Omap3 doesn't work unless you enable the emu clk, which
> is done in kernel/etm.c. Rather than duplicate that code (which only seems
> to be needed for Omap anyway) I decided to add a dependency on OMAP3_EMU so
> the clock gets enabled in etb_probe.
>
>> So fix it that we can build pmu into kernel to support perf
>> for some valid config(such as enable both omap4 and omap3,
>> but OMAP3_EMU).
>
> No, I don't like this. The reason I don't like it is because it will lead to
> lots of bug reports that perf doesn't work on Omap3 because they haven't got
> the emu clock ticking. It was this scenario that led to the dependency being
> introduced in the first place:
>
> 8954bb0d ("OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU")

I don't think it is good fix.

In fact, we should keep arch/arm/Kconfig or arch/arm/kernel/pmu.c more generic,
and avoid to make arm core code depend on machines options as far as possible.

For the pmu issue on omap3, below fix should be better than what
8954bb0d did, shouldn't it?

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b85585..c20a3a3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -410,9 +410,12 @@ static void omap_init_pmu(void)
 {
 	if (cpu_is_omap24xx())
 		omap_pmu_device.resource = &omap2_pmu_resource;
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx()) {
 		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
+#ifndef  CONFIG_OMAP3_EMU
+		return;
+#endif
+	} else
 		return;

 	platform_device_register(&omap_pmu_device);


> Is there a problem building the etm support for Omap4?

Of course,  there is the problem I described above.


thanks,
-- 
Ming Lei
