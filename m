From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3
 and CONFIG_VFPv3 set
Date: Mon, 15 Oct 2012 01:58:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210150157400.16624@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com> <20121013090255.GT28061@n2100.arm.linux.org.uk> <yw1xr4p2myre.fsf@unicorn.mansr.com> <20121013133654.GU28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-30510800-1350266312=:16624"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab2JOB6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Oct 2012 21:58:33 -0400
In-Reply-To: <20121013133654.GU28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans.rullgard@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-30510800-1350266312=:16624
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: fix
saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP board
started crashing during boot with omap2plus_defconfig:

[    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
[    3.915954]  mmcblk0: p1
[    4.086639] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[    4.093719] Modules linked in:
[    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
[    4.103149] PC is at vfp_reload_hw+0x1c/0x44
[    4.107666] LR is at __und_usr_fault_32+0x0/0x8

It turns out that the context save/restore fix unmasked a latent bug
in commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Make
VFPv3 usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel is
booted on a pre-VFPv3 core, the code attempts to save and restore the
d16-d31 VFP registers.  These are only present on non-D16 VFPv3+, so
this results in an undefined instruction exception.  The code didn't
crash before commit 846a136 because the save and restore code was
only touching d0-d15, present on all VFP.

Fix by implementing a request from Russell King to add a new HWCAP
flag that affirmatively indicates the presence of the d16-d31
registers:

   http://marc.info/?l=3Dlinux-arm-kernel&m=3D135013547905283&w=3D2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: M=E5ns Rullg=E5rd <mans.rullgard@linaro.org>
---
Applies on v3.7-rc1.

 arch/arm/include/asm/vfpmacros.h  |   12 ++++++------
 arch/arm/include/uapi/asm/hwcap.h |    3 ++-
 arch/arm/vfp/vfpmodule.c          |    9 ++++++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmac=
ros.h
index 6a6f1e4..77f40ea 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -27,9 +27,9 @@
 #if __LINUX_ARM_ARCH__ <=3D 6
 =09ldr=09\tmp, =3Delf_hwcap=09=09    @ may not have MVFR regs
 =09ldr=09\tmp, [\tmp, #0]
-=09tst=09\tmp, #HWCAP_VFPv3D16
-=09ldceql=09p11, cr0, [\base],#32*4=09=09    @ FLDMIAD \base!, {d16-d31}
-=09addne=09\base, \base, #32*4=09=09    @ step over unused register space
+=09tst=09\tmp, #HWCAP_VFPD16
+=09ldcnel=09p11, cr0, [\base],#32*4=09=09    @ FLDMIAD \base!, {d16-d31}
+=09addeq=09\base, \base, #32*4=09=09    @ step over unused register space
 #else
 =09VFPFMRX=09\tmp, MVFR0=09=09=09    @ Media and VFP Feature Register 0
 =09and=09\tmp, \tmp, #MVFR0_A_SIMD_MASK=09    @ A_SIMD field
@@ -51,9 +51,9 @@
 #if __LINUX_ARM_ARCH__ <=3D 6
 =09ldr=09\tmp, =3Delf_hwcap=09=09    @ may not have MVFR regs
 =09ldr=09\tmp, [\tmp, #0]
-=09tst=09\tmp, #HWCAP_VFPv3D16
-=09stceql=09p11, cr0, [\base],#32*4=09=09    @ FSTMIAD \base!, {d16-d31}
-=09addne=09\base, \base, #32*4=09=09    @ step over unused register space
+=09tst=09\tmp, #HWCAP_VFPD16
+=09stcnel=09p11, cr0, [\base],#32*4=09=09    @ FSTMIAD \base!, {d16-d31}
+=09addeq=09\base, \base, #32*4=09=09    @ step over unused register space
 #else
 =09VFPFMRX=09\tmp, MVFR0=09=09=09    @ Media and VFP Feature Register 0
 =09and=09\tmp, \tmp, #MVFR0_A_SIMD_MASK=09    @ A_SIMD field
diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/=
hwcap.h
index f254f65..b1555d0 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -18,11 +18,12 @@
 #define HWCAP_THUMBEE=09(1 << 11)
 #define HWCAP_NEON=09(1 << 12)
 #define HWCAP_VFPv3=09(1 << 13)
-#define HWCAP_VFPv3D16=09(1 << 14)
+#define HWCAP_VFPv3D16=09(1 << 14)=09/* also set for VFPv4-D16 */
 #define HWCAP_TLS=09(1 << 15)
 #define HWCAP_VFPv4=09(1 << 16)
 #define HWCAP_IDIVA=09(1 << 17)
 #define HWCAP_IDIVT=09(1 << 18)
+#define HWCAP_VFPD16=09(1 << 19)=09/* set if VFP has 32 regs (not 16) */
 #define HWCAP_IDIV=09(HWCAP_IDIVA | HWCAP_IDIVT)
=20
=20
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index c834b32..f3e611c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -701,11 +701,14 @@ static int __init vfp_init(void)
 =09=09=09elf_hwcap |=3D HWCAP_VFPv3;
=20
 =09=09=09/*
-=09=09=09 * Check for VFPv3 D16. CPUs in this configuration
-=09=09=09 * only have 16 x 64bit registers.
+=09=09=09 * Check for VFPv3 D16 and VFPv4 D16.  CPUs in
+=09=09=09 * this configuration only have 16 x 64bit
+=09=09=09 * registers.
 =09=09=09 */
 =09=09=09if (((fmrx(MVFR0) & MVFR0_A_SIMD_MASK)) =3D=3D 1)
-=09=09=09=09elf_hwcap |=3D HWCAP_VFPv3D16;
+=09=09=09=09elf_hwcap |=3D HWCAP_VFPv3D16; /* also v4-D16 */
+=09=09=09else
+=09=09=09=09elf_hwcap |=3D HWCAP_VFPD16;
 =09=09}
 #endif
 =09=09/*
--=20
1.7.10.4

--843723315-30510800-1350266312=:16624--
