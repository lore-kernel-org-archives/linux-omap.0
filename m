From: Dmitry Shvedov <dmt.shvedov@gmail.com>
Subject: Compilation Issue with OMAP_SMARTREFLEX, CONFIG_USB_ARCH_HAS_EHCI
Date: Mon, 20 Apr 2009 15:37:00 -0400
Message-ID: <521dce150904201237m1f157a39jef5a91e6675d24b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:38560 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbZDTTng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 15:43:36 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1414004ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 12:43:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
The following set of .config settings:

#CONFIG_PM set to OFF
CONFIG_USB_ARCH_HAS_EHCI=y

triggers the following compile error:
...
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap3_sr_init':
usb-ehci.c:(.init.text+0xc0c): undefined reference to `power_kobj'
make: *** [.tmp_vmlinux1] Error 1

When EHCI is turned off, the error becomes:

arch/arm/mach-omap2/built-in.o: In function `omap3_sr_init':
board-omap3evm-flash.c:(.init.text+0xc0c): undefined reference to `power_kobj'
make: *** [.tmp_vmlinux1] Error 1

Error disappears when  Smart reflex is turned off:
#OMAP_SMARTREFLEX set to OFF

Than the kernel compiles OK.

-dmt
