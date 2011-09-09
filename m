From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Fri, 9 Sep 2011 19:41:08 +0530
Message-ID: <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
 <20110909080416.GF31581@S2100-06.ap.freescale.net> <4E69C9CF.6090709@ti.com> <20110909141321.GC32138@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33715 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754536Ab1IIOL3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 10:11:29 -0400
Received: by mail-yi0-f44.google.com with SMTP id 12so394349yie.17
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 07:11:28 -0700 (PDT)
In-Reply-To: <20110909141321.GC32138@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Fri, Sep 9, 2011 at 7:43 PM, Shawn Guo <shawn.guo@freescale.com> wro=
te:
> On Fri, Sep 09, 2011 at 01:39:51PM +0530, Santosh wrote:
>> On Friday 09 September 2011 01:34 PM, Shawn Guo wrote:
>> >Hi Santosh,
>> >
>> >On Sun, Sep 04, 2011 at 07:24:15PM +0530, Santosh Shilimkar wrote:
>> >>This patch adds the CPU0 and CPU1 off mode support. CPUX close swi=
tch
>> >>retention (CSWR) is not supported by hardware design.
>> >>
>> >>The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>> >>
>> >>CPUx sleep code is common for hotplug, suspend and CPUilde.
>> >>
>> >>Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> >>Cc: Kevin Hilman<khilman@ti.com>
>> >>---
>> >> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A03 +-
>> >> =A0arch/arm/mach-omap2/include/mach/omap-secure.h =A0| =A0 =A08 +
>> >> =A0arch/arm/mach-omap2/include/mach/omap4-common.h | =A0 25 +++
>> >> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c =A0 =A0 =A0 | =A0249=
 +++++++++++++++++++++++
>> >> =A0arch/arm/mach-omap2/omap-smp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A06 +
>> >> =A0arch/arm/mach-omap2/omap4-sar-layout.h =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 +
>> >> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A06 +
>> >> =A0arch/arm/mach-omap2/sleep44xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0213 +++++++++++++++++++
>> >> =A08 files changed, 518 insertions(+), 1 deletions(-)
>> >> =A0create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> >>
>> >
>> >[...]
>> >
>> >>diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2=
/sleep44xx.S
>> >>index 049f426..230ab8c 100644
>> >>--- a/arch/arm/mach-omap2/sleep44xx.S
>> >>+++ b/arch/arm/mach-omap2/sleep44xx.S
>> >>@@ -11,8 +11,221 @@
>> >>
>> >> =A0#include<linux/linkage.h>
>> >> =A0#include<asm/system.h>
>> >>+#include<asm/smp_scu.h>
>> >>+#include<asm/memory.h>
>> >>+#include<asm/hardware/cache-l2x0.h>
>> >>
>> >>+#include<plat/omap44xx.h>
>> >> =A0#include<mach/omap4-common.h>
>> >>+#include<mach/omap-secure.h>
>> >>+
>> >>+#include "omap4-sar-layout.h"
>> >>+
>> >>+#ifdef CONFIG_SMP
>> >>+
>> >>+.macro =A0 =A0 DO_SMC
>> >>+ =A0 dsb
>> >>+ =A0 smc =A0 =A0 #0
>> >>+ =A0 dsb
>> >>+.endm
>> >>+
>> >>+ppa_zero_params:
>> >>+ =A0 .word =A0 =A0 =A0 =A0 =A0 0x0
>> >>+
>> >>+/*
>> >>+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> >>+ * =3D=3D CPU suspend finisher =3D=3D
>> >>+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> >>+ *
>> >>+ * void omap4_finish_suspend(unsigned long cpu_state)
>> >>+ *
>> >>+ * This function code saves the CPU context and performs the CPU
>> >>+ * power down sequence. Calling WFI effectively changes the CPU
>> >>+ * power domains states to the desired target power state.
>> >>+ *
>> >>+ * @cpu_state : contains context save state (r0)
>> >>+ * 0 - No context lost
>> >>+ * =A0 =A0 =A0 =A0 1 - CPUx L1 and logic lost: MPUSS CSWR
>> >>+ * =A0 =A0 =A0 =A0 2 - CPUx L1 and logic lost + GIC lost: MPUSS O=
SWR
>> >>+ * 3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
>> >
>> >I was told by rmk that same as imx6q, omap44xx will retain L2 conte=
nt
>> >across suspen/resume cycle. =A0Then what does "L2 lost" mean here? =
=A0Or
>> >what rmk meant is the case cpu_state =3D=3D 2?
>> >
>> Yes.
>>
>> The last case is entire SOC OFF. We call Device OFF in OMAP.
>> All voltages will scale to 0 V. This isn't supported by this
>> series.
>>
> Then the second question would be what the following patch in this
> series is for.
>
> =A0 =A0[PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
>
> I could have read the patch incorrectly, but it seems l2x_clean_inv
> will also be called for "MPUSS OSWR" in which case L2 is retained?
> Shouldn't L2 for this case have been handled by rmk's patch (ARM: pm:
> add L2 cache cleaning for suspend)?
>
Yes you did read it wrongly :)
It won't be called for OSWR
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
