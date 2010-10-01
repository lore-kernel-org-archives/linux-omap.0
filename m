From: Grazvydas Ignotas <notasas@gmail.com>
Subject: multiple linux-next OMAP3 build errors
Date: Fri, 1 Oct 2010 18:57:46 +0300
Message-ID: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35806 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0JAP5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 11:57:49 -0400
Received: by qyk9 with SMTP id 9so1122274qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 08:57:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

hi,

I've been building linux-next for a while now and keep getting these
build errors, just posting them here in case not all are known. Not
familiar enough with that code to send patches unfortunately.

  AS      arch/arm/mm/proc-v7.o
arch/arm/mm/proc-v7.S: Assembler messages:
arch/arm/mm/proc-v7.S:363: Error: undefined symbol `PMD_FLAGS' in operation

  CC      drivers/usb/musb/musb_gadget.o
drivers/usb/musb/musb_gadget.c:1789: error:
'usb_gadget_register_driver' undeclared here (not in a function)
drivers/usb/musb/musb_gadget.c:1789: warning: type defaults to 'int'
in declaration of 'usb_gadget_register_driver'

  CC      drivers/video/omap2/vram.o
drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
drivers/video/omap2/vram.c:568: error: implicit declaration of
function 'memblock_region_is_memory'

  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `serial_write_reg':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:168:
undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap_uart_prepare_idle':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:404:
undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/pm34xx.c:484:
undefined reference to `sleep_while_idle'

I'm using this customized config:
http://notaz.gp2x.de/misc/pnd/config_next_101001
