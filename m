From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address space.
Date: Tue, 8 May 2012 19:31:57 +0530
Message-ID: <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48290 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773Ab2EHOCX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 10:02:23 -0400
Received: by qafl39 with SMTP id l39so616211qaf.9
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 07:02:21 -0700 (PDT)
In-Reply-To: <20120508124116.GE17798@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>, Russell King <linux@arm.linux.org.uk>

On Tue, May 8, 2012 at 6:11 PM, Catalin Marinas <catalin.marinas@arm.co=
m> wrote:
> On Mon, May 07, 2012 at 02:42:29PM +0100, Santosh Shilimkar wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> ARM decompressor code setups entire 4GB address space pages.
>> Out of the 4GB, about 256MB are setup with normal memory attributes
>> for needed DRAM and the rest of the address space as Strongly ordere=
d.
>>
>> But since all the sections are mapped in DOMAIN0(Manager), processor
>> like Cortex-A15, can speculatively prefetch from non-DRAM read sensi=
tive
>> areas even in the presence of XN(Non-executable). This is because XN
>> attribute is ignored when domain is Manager.
>>
>> This can lead to accesses to non-accessible address regions leading
>> to various interconnect violations. The issue is observed on OMAP5.
>>
>> This patch tries to fix the issue by ensuring that non-DRAM region
>> is marked as a client domain so that XN attribute is effective.
>>
>> A better alternative is to not map un-used regions but since the
>> decompressor code is generic, there might be many exceptions
>> for the devices used like debug console etc.
>>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>> =A0arch/arm/boot/compressed/head.S | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compres=
sed/head.S
>> index dc7e8ce..4dc799b 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -578,7 +578,7 @@ __setup_mmu: =A0 =A0 =A0sub =A0 =A0 r3, r4, #163=
84 =A0 =A0 =A0 =A0 =A0@ Page directory size
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r9, r0, lsr #18
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r9, r9, lsl #18 =A0 =A0 =A0 =
=A0 @ start of RAM
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 add =A0 =A0 r10, r9, #0x10000000 =A0 =A0=
@ a reasonable RAM size
>> - =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r1, #0x12
>> + =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r1, #0x32 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 @ set domain1, XN, valid
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 orr =A0 =A0 r1, r1, #3 << 10
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 add =A0 =A0 r2, r3, #16384
>> =A01: =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 r1, r9 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0@ if virt > start of RAM
>> @@ -587,8 +587,10 @@ __setup_mmu: =A0 =A0 sub =A0 =A0 r3, r4, #16384=
 =A0 =A0 =A0 =A0 =A0@ Page directory size
>> =A0#else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 orrhs =A0 r1, r1, #0x0c =A0 =A0 =A0 =A0 =
=A0 @ set cacheable, bufferable
>> =A0#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 bichs =A0 r1, r1, #0x20 =A0 =A0 =A0 =A0 =A0=
 @ set domain0 for DRAM
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 r1, r10 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 @ if virt > end of RAM
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bichs =A0 r1, r1, #0x0c =A0 =A0 =A0 =A0 =
=A0 @ clear cacheable, bufferable
>> + =A0 =A0 =A0 =A0 =A0 =A0 orrhs =A0 r1, r1, #0x20 =A0 =A0 =A0 =A0 =A0=
 @ set domain1
>
> I would leave the same domain (0, set as client) and rather change th=
e
> XN and cacheability bits once we finished with the DRAM. I think it's
> cleaner assuming we have two domains and the manager one overrides th=
e
> XN bit.
>
Ok. Assuming you mean " it's _not_ cleaner to have two domains where
manager overrides XN attributes" Note that DRAM can be in the middle of
4GB address space, so we need to take care of bottom and top address
space.

Update patch end of the email. Is that fine with you ?

Regards
Santosh

=46rom b906ef372f0e2dfa7e1fbc3c87406b1c303d8975 Mon Sep 17 00:00:00 200=
1
=46rom: R Sricharan <r.sricharan@ti.com>
Date: Mon, 7 May 2012 15:11:58 +0530
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM addres=
s
 space.

ARM decompressor code setups entire 4GB address space pages.
Out of the 4GB, about 256MB are setup with normal memory attributes
for needed DRAM and the rest of the address space as Strongly ordered.

But since all the sections are mapped in DOMAIN0(Manager), processor
like Cortex-A15, can speculatively prefetch from non-DRAM read sensitiv=
e
areas even in the presence of XN(Non-executable). This is because XN
attribute is ignored when domain is Manager.

This can lead to accesses to non-accessible address regions leading
to various interconnect violations. The issue is observed on OMAP5.

This patch tries to fix the issue by ensuring that all regions
are marked as a client domain so that XN attribute is effective.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/boot/compressed/head.S |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed=
/head.S
index dc7e8ce..a2602b8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -578,10 +578,12 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory=
 size
 		mov	r9, r0, lsr #18
 		mov	r9, r9, lsl #18		@ start of RAM
 		add	r10, r9, #0x10000000	@ a reasonable RAM size
-		mov	r1, #0x12
+		mov	r1, #0x02		@ Default executable section
 		orr	r1, r1, #3 << 10
 		add	r2, r3, #16384
 1:		cmp	r1, r9			@ if virt > start of RAM
+		orrlo	r1, r1, #0x10		@ Mark XN for non DRAM
+		bichs	r1, r1, #0x10		@ clear XN for DRAM
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 		orrhs	r1, r1, #0x08		@ set cacheable
 #else
@@ -589,6 +591,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory s=
ize
 #endif
 		cmp	r1, r10			@ if virt > end of RAM
 		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
+		orrhs	r1, r1, #0x10		@ Mark XN for non DRAM
 		str	r1, [r0], #4		@ 1:1 mapping
 		add	r1, r1, #1048576
 		teq	r0, r2
@@ -599,7 +602,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory s=
ize
  * so there is no map overlap problem for up to 1 MB compressed kernel=
=2E
  * If the execution is in RAM then we would only be duplicating the ab=
ove.
  */
-		mov	r1, #0x1e
+		mov	r1, #0x0e		@ Clear XN
 		orr	r1, r1, #3 << 10
 		mov	r2, pc
 		mov	r2, r2, lsr #20
@@ -658,6 +661,9 @@ __armv7_mmu_cache_on:
 		movne	r1, #-1
 		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
+		bic	r1, r1, #0x03		@ Clear domain0 bits
+		orr	r1, r1, #0x01		@ Set domain0 as client
+		mcr	p15, 0, r1, c3, c0, 0
 #endif
 		mcr	p15, 0, r0, c7, c5, 4	@ ISB
 		mcr	p15, 0, r0, c1, c0, 0	@ load control register
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
