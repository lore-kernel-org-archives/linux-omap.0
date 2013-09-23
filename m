From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v3] ARM: VExpress: Makefile: add armv7 flags for inline assmembly
 code compiling
Date: Mon, 23 Sep 2013 09:50:12 +0800
Message-ID: <523F9E54.70907@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com> <20130822102210.GF25647@n2100.arm.linux.org.uk> <5216BF16.2080006@asianux.com> <5216C389.9050605@asianux.com> <5216D138.6080802@asianux.com> <5216D31B.9050609@asianux.com> <20130823055152.GY7656@atomide.com> <52170900.5070909@asianux.com> <52170C15.5010907@asianux.com> <52171720.4050501@asianux.com> <52171978.7080805@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:14881 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab3IWBvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Sep 2013 21:51:16 -0400
In-Reply-To: <52171978.7080805@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


When 'vexpress' kernel is compiled for both v6 and v7, it can support
armv7 instructions in lower level modules, so need let compiler know
about it for related inline assembly code, or can not pass compiling.

The related failure command:

  arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -Os -Wno-maybe-uninitialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fstack-protector -mabi=aapcs-linux -mno-thumb-interwork -funwind-
 tables -marm -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=1024 -Wno-unused-but-se
 t-variabl

e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-debug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -W     -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/.tmp_dcscb.o arch/arm/mach-vexpress/dcscb.c

The related error:

  /tmp/ccOMIprI.s: Assembler messages:
  /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mode `isb '
  /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mode `isb '
  /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mode `dsb '
  /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mode `isb '
  /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mode `isb '
  /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mode `dsb '
  make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
  make: *** [arch/arm/mach-vexpress] Error 2


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-vexpress/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 36ea824..f224577 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -10,3 +10,6 @@ obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
 obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
+
+CFLAGS_dcscb.o				+=-march=armv7-a
+CFLAGS_tc2_pm.o				+=-march=armv7-a
-- 
1.7.7.6
