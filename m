From: Kovacs Peter Tamas <p.kovacs@holografika.com>
Subject: Unable to compile kernel with omap_ldp_defconfig
Date: Wed, 12 Aug 2009 12:34:22 +0200
Message-ID: <4A829AAE.5000705@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail00a.mail.t-online.hu ([84.2.40.5]:50203 "EHLO
	mail00a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbZHLKk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 06:40:56 -0400
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail00a.mail.t-online.hu (Postfix) with ESMTPSA id 505CF268CFC
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 12:32:09 +0200 (CEST)
Received: from [192.168.0.3] (port=40812)
	by holoiroda.com with esmtpsa (Exim 4.69-NetSys #4)
	id 1MbBA4-0003Tj-Kh
	for linux-omap@vger.kernel.org; Wed, 12 Aug 2009 12:34:28 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear All,

I'm trying to compile the kernel for my Logic LDP3430-VG1.0.0.
Following the instructions at
https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel
and
https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing

I was able to compile the x-loader and u-boot (both with 
omap3430labrador_config), but the kernel with omap_ldp_defconfig (as it 
was yesterday in the ti-2.6.27-omap3 git) did not compile saying:

omap@omap-devel:~/OMAP_kernel/bootloader_build/omapkernel$ make 
CROSS_COMPILE=arm-none-linux-gnueabi- uImage
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
<stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1321:2: warning: #warning syscall pselect6 not implemented
<stdin>:1325:2: warning: #warning syscall ppoll not implemented
<stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
  CHK     include/linux/compile.h
  AS      arch/arm/kernel/debug.o
arch/arm/plat-omap/include/mach/debug-macro.S: Assembler messages:
arch/arm/plat-omap/include/mach/debug-macro.S:39: Error: invalid 
constant (fb6000) after fixup
arch/arm/plat-omap/include/mach/debug-macro.S:39: Error: invalid 
constant (fb6000) after fixup
make[1]: *** [arch/arm/kernel/debug.o] Error 1
make: *** [arch/arm/kernel] Error 2

Please note that it compiles fine with the omap_3430sdp_defconfig.

Could you please help me with this issue?

Thanks for your help,
Peter
