From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: usb_nop_xceiv_register() missing when OTG built as modules
Date: Thu, 4 Mar 2010 09:59:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
References: <87635d54nn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212Ab0CDE35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 23:29:57 -0500
In-Reply-To: <87635d54nn.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, March 04, 2010 5:39 AM
> To: linux-omap@vger.kernel.org
> Subject: usb_nop_xceiv_register() missing when OTG built as modules
> 
> This just started happening with v2.6.33.
> 
> On OMAP3EVM, usb_nop_xceiv_register() is called in the board file,
> but if USB gadget support is built as a module, this causes a link
> error (below)

Kevin,

usb_nop_xceiv_register() is defined at drivers/usb/otg/nop-usb-xceiv.c file
which gets compiled if CONFIG_NOP_USB_XCEIV=y.

I think you have enabled CONFIG_NOP_USB_XCEIV as module?

Regards,
Ajay

> 
> This is obviously broken, and this hook needs to be fixed to work when
> called as a module.
> 
> To reproduce, start with omap3_defconfig and change both USB host
> and gadget to be built as modules.
> 
> Kevin
> 
> 
>   [...]
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
> /opt/home/khilman/work.local/kernel/omap/dev/arch/arm/mach-omap2/board-
> omap3evm.c:686: undefined reference to `usb_nop_xceiv_register'
> arch/arm/mach-omap2/built-in.o: In function `omap_4430sdp_init':
> /opt/home/khilman/work.local/kernel/omap/dev/arch/arm/mach-omap2/board-
> 4430sdp.c:143: undefined reference to `usb_nop_xceiv_register'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
