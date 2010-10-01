From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: multiple linux-next OMAP3 build errors
Date: Fri, 1 Oct 2010 21:42:13 +0530
Message-ID: <66d796b6ecbd63bba36875b86752cedb@mail.gmail.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49786 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751684Ab0JAQMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 12:12:16 -0400
Received: by mail-wy0-f181.google.com with SMTP id 28so3569739wyf.12
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 09:12:14 -0700 (PDT)
In-Reply-To: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Grazvydas Ignotas wrote:
>
> hi,
>
> I've been building linux-next for a while now and keep getting these
> build errors, just posting them here in case not all are known. Not
> familiar enough with that code to send patches unfortunately.
>
>   AS      arch/arm/mm/proc-v7.o
> arch/arm/mm/proc-v7.S: Assembler messages:
> arch/arm/mm/proc-v7.S:363: Error: undefined symbol `PMD_FLAGS' in
operation
>
>   CC      drivers/usb/musb/musb_gadget.o
> drivers/usb/musb/musb_gadget.c:1789: error: 'usb_gadget_register_driver'
undeclared here (not in a function)
> drivers/usb/musb/musb_gadget.c:1789: warning: type defaults to 'int' in
declaration of 'usb_gadget_register_driver'
>
>   CC      drivers/video/omap2/vram.o
> drivers/video/omap2/vram.c: In function
'omap_vram_reserve_sdram_memblock':
> drivers/video/omap2/vram.c:568: error: implicit declaration of function
'memblock_region_is_memory'
>
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `serial_write_reg':
> /home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:168:
undefined reference to `enable_off_mode'
> arch/arm/mach-omap2/built-in.o: In function `omap_uart_prepare_idle':
> /home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:404:
undefined reference to `enable_off_mode'
> arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
> /home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/pm34xx.c:484:
undefined reference to `sleep_while_idle'
>
> I'm using this customized config:
> http://notaz.gp2x.de/misc/pnd/config_next_101001


Thanks for reporting. I'll take a stab at fixing some of these.

We've been playing with autobuilding linux-omap and linux-omap-pm,
but didn't think of looking at linux-next. We'll start now.

- Anand
