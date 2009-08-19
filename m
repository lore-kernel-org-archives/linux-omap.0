From: "Premi, Sanjeev" <premi@ti.com>
Subject: Kernel doesn't build on master (751797c)
Date: Wed, 19 Aug 2009 15:50:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48355 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZHSKUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 06:20:37 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7JAKWjW002196
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 05:20:38 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7JAKV9G017230
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 15:50:32 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

The kernel doesn't build with the latest patch on the master.
I had reported this missing endif in response to your patch yesterday as well.

Screenshot from my terminal is attached below.

Best regards,
Sanjeev

premi # git pull
Updating e087f6f..751797c
Fast forward
 arch/arm/plat-omap/include/mach/cpu.h |   35 +++++++++++---------------------
 1 files changed, 12 insertions(+), 23 deletions(-)
premi #
premi #
premi #
premi # make clean
  CLEAN   arch/arm/boot/compressed
  CLEAN   arch/arm/boot
  CLEAN   /db/psp_git/users/a0756819/linux-omap-2.6
  CLEAN   arch/arm/kernel
  CLEAN   drivers/char
  CLEAN   init
  CLEAN   kernel
  CLEAN   lib
  CLEAN   usr
  CLEAN   .tmp_versions
  CLEAN   include/asm-arm/mach-types.h vmlinux System.map .tmp_kallsyms1.S .tmp_kallsyms1.o .tmp_kallsyms2.S .tmp_kallsyms2.o .tmp_kallsyms3.S .tmp_kallsyms3.o .tmp_vmlinux1 .tmp_vmlinux2 .tmp_vmlinux3 .tmp_System.map
premi # make omap3_evm_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/basic/hash
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
premi # make uImage
scripts/kconfig/conf -s arch/arm/Kconfig
  CHK     include/linux/version.h
  Generating include/asm-arm/mach-types.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-arm
  CC      kernel/bounds.s
  GEN     include/linux/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/asm/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1351:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1407:2: warning: #warning syscall pselect6 not implemented
<stdin>:1411:2: warning: #warning syscall ppoll not implemented
<stdin>:1451:2: warning: #warning syscall epoll_pwait not implemented
  HOSTCC  scripts/genksyms/genksyms.o
  HOSTCC  scripts/genksyms/lex.o
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      init/main.o
In file included from arch/arm/plat-omap/include/mach/hardware.h:42,
                 from arch/arm/plat-omap/include/mach/irqs.h:564,
                 from /db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/include/asm/irq.h:4,
                 from /db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:10,
                 from include/linux/interrupt.h:12,
                 from include/linux/kernel_stat.h:8,
                 from init/main.c:33:
arch/arm/plat-omap/include/mach/cpu.h:30:1: error: unterminated #ifndef
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2