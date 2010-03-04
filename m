From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: usb_nop_xceiv_register() missing when OTG built as modules
Date: Wed, 03 Mar 2010 16:09:16 -0800
Message-ID: <87635d54nn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:63604 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab0CDAJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 19:09:32 -0500
Received: by ywh35 with SMTP id 35so659583ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 16:09:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This just started happening with v2.6.33.

On OMAP3EVM, usb_nop_xceiv_register() is called in the board file,
but if USB gadget support is built as a module, this causes a link
error (below)

This is obviously broken, and this hook needs to be fixed to work when
called as a module.

To reproduce, start with omap3_defconfig and change both USB host
and gadget to be built as modules.

Kevin


  [...]
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
/opt/home/khilman/work.local/kernel/omap/dev/arch/arm/mach-omap2/board-omap3evm.c:686: undefined reference to `usb_nop_xceiv_register'
arch/arm/mach-omap2/built-in.o: In function `omap_4430sdp_init':
/opt/home/khilman/work.local/kernel/omap/dev/arch/arm/mach-omap2/board-4430sdp.c:143: undefined reference to `usb_nop_xceiv_register'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2
