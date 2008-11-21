From: "Amit Pundir" <pundiramit@gmail.com>
Subject: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 15:34:07 +0530
Message-ID: <52c7556c0811210204h13f4a582r7d3add4b790863f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:26566 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYKUKEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 05:04:09 -0500
Received: by ti-out-0910.google.com with SMTP id b6so583102tic.23
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 02:04:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Greetings!

Can anyone please tell me which defconfig should I use for building
linux-omap kernel (linux-2.6.22.1 + patch-2.6.22-omap1) for my
omap3evm board? I'm getting the following error if I use
omap3evm_defconfig(with IPV6 enabled and PM disabled) that comes with
the TI kernel.

------------------------------------------------------------------
  CC      lib/vsprintf.o
  AR      lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arm-none-linux-gnueabi-ld: no machine record defined
arm-none-linux-gnueabi-ld: no machine record defined
drivers/built-in.o: In function `omapfb_do_probe':
/home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/video/omap/omapfb_main.c:1777:
undefined reference to `omap2_int_ctrl'
drivers/built-in.o: In function `musb_stage2_irq':
/home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/usb/musb/plat_uds.c:739:
undefined reference to `musb_hnp_stop'
make: *** [.tmp_vmlinux1] Error 1
------------------------------------------------------------------

Is there any patch or work-around available for this problem?
Thanks for your concern.

Regards
Amit Pundir
