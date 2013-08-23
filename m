From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM: VExpress: Kconfig: avoid arm6 compatible for ARCH_VEXPRESS
Date: Fri, 23 Aug 2013 11:12:27 +0800
Message-ID: <5216D31B.9050609@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com> <20130822102210.GF25647@n2100.arm.linux.org.uk> <5216BF16.2080006@asianux.com> <5216C389.9050605@asianux.com> <5216D138.6080802@asianux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060803070302080005070501"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:16859 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab3HWDN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 23:13:28 -0400
In-Reply-To: <5216D138.6080802@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This is a multi-part message in MIME format.
--------------060803070302080005070501
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/23/2013 11:04 AM, Chen Gang wrote:
> ARCH_VEXPRESS isn't compatible with arm6 (not support "-march=armv6k"),
> so add dependency for it, or allmodconfig can not pass compiling.
> 
> The related command:
> 
>   arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -Os -Wno-maybe-uninitialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fstack-protector -mabi=aapcs-linux -mno-thumb-interwork -funwin
 d-tables -marm -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=1024 -Wno-unused-but-
 set-varia
bl
> e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-debug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -W     -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/.tmp_dcscb.o arch/arm/mach-vexpress/dcscb.c
> 
> The related error:
> 
>   /tmp/ccOMIprI.s: Assembler messages:
>   /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mode `dsb '
>   /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mode `dsb '
>   make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>   make: *** [arch/arm/mach-vexpress] Error 2
> 
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-vexpress/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 3657954..945e2f9 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_VEXPRESS
> -	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
> +	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7 && !ARCH_MULTI_V6 && !CPU_V6 && !CPU_V6K
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_GIC
> 

Oh, sorry, we do not need check ARCH_MULTI_V6, the new patch is in
attachment.


--------------060803070302080005070501
Content-Type: text/x-patch;
 name="0001-fixing.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-fixing.patch"

ARCH_VEXPRESS isn't compatible with arm6 (not support "-march=3Darmv6k"),=

so add dependency for it, or allmodconfig can not pass compiling.

The related command:

  arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostd=
inc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-nex=
t/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-=
next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linu=
x-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/in=
clude/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-impli=
cit-function-declaration -Wno-format-security -fno-delete-null-pointer-ch=
ecks -Werror=3Dimplicit-int -Werror=3Dstrict-prototypes -Os -Wno-maybe-un=
initialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched=
-prolog -fstack-protector -mabi=3Daapcs-linux -mno-thumb-interwork -funwi=
nd-tables -marm -D__LINUX_ARM_ARCH__=3D6 -march=3Darmv6k -mtune=3Darm1136=
j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial=
-inlining -Wframe-larger-than=3D1024 -Wno-unused-but-set-variabl
e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-de=
bug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wde=
claration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconser=
ve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/inc=
lude -I/root/linux-next/arch/arm/plat-versatile/include -W     -D"KBUILD_=
STR(s)=3D#s" -D"KBUILD_BASENAME=3DKBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=3D=
KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/.tmp_dcscb.o arch/arm/mac=
h-vexpress/dcscb.c

The related error:

  /tmp/ccOMIprI.s: Assembler messages:
  /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mod=
e `isb '
  /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mod=
e `isb '
  /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mod=
e `dsb '
  /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mod=
e `isb '
  /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mod=
e `isb '
  /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mod=
e `dsb '
  make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
  make: *** [arch/arm/mach-vexpress] Error 2


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-vexpress/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kcon=
fig
index 3657954..9b176ce 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_VEXPRESS
-	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
+	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7 && !CPU_V6 &&=
 !CPU_V6K
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
--=20
1.7.7.6


--------------060803070302080005070501--
