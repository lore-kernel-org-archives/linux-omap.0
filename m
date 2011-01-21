From: Felipe Balbi <balbi@ti.com>
Subject: Re: 2.6.38-rc1-git1 musb undefined references
Date: Fri, 21 Jan 2011 05:22:36 +0200
Message-ID: <20110121032236.GB2448@legolas.emea.dhcp.ti.com>
References: <4D386129.4080206@blueyonder.co.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50082 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739Ab1AUDWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 22:22:43 -0500
Content-Disposition: inline
In-Reply-To: <4D386129.4080206@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

(please, keep also linux-usb@vger on the Cc list on any patch regarding
drivers/usb)

On Thu, Jan 20, 2011 at 04:22:01PM +0000, Sid Boyce wrote:
> Cross compiling for Beagleboard on Ubuntu 11.04 x86_64.
> # make-kpkg --revision=0 --append-to-version=-custom --arch=armel
> --cross-compile=/opt/arm-2010q1/bin/arm-none-linux-gnueabi-
> kernel-image --initrd
> 
> ====== making target debian/stamp/build/kernel [new prereqs: vars]======
> This is kernel package version 12.036+nmu1.
> restore_upstream_debianization
> test ! -f scripts/package/builddeb.kpkg-dist || mv -f
> scripts/package/builddeb.kpkg-dist scripts/package/builddeb
> test ! -f scripts/package/Makefile.kpkg-dist || mv -f
> scripts/package/Makefile.kpkg-dist scripts/package/Makefile
> /usr/bin/make  EXTRAVERSION=-rc1-git1-custom  ARCH=arm \
> 
> CROSS_COMPILE=/opt/arm-2010q1/bin/arm-none-linux-gnueabi- zImage
> make[1]: Entering directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
> scripts/kconfig/conf --silentoldconfig Kconfig
> make[1]: Leaving directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
> make[1]: Entering directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   LD      fs/built-in.o
>   LD      lib/zlib_deflate/built-in.o
>   LD      lib/built-in.o
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: modpost: Found 3 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `musb_free':
> clkdev.c:(.text+0xf3d08): undefined reference to `dma_controller_destroy'
> drivers/built-in.o: In function `musb_probe':
> clkdev.c:(.init.text+0x64a8): undefined reference to `dma_controller_create'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
> make: *** [debian/stamp/build/kernel] Error 2
> root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1#

I just compiled 2.6.38-rc1 and it doesn't fail for me.

> root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1# grep OMAP2PLUS .config
> CONFIG_ARCH_OMAP2PLUS=y
> CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
> # CONFIG_USB_MUSB_OMAP2PLUS is not set
> root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1# grep MUSB .config
> CONFIG_USB_MUSB_HDRC=y
> # CONFIG_USB_MUSB_TUSB6010 is not set
> # CONFIG_USB_MUSB_OMAP2PLUS is not set
> CONFIG_USB_MUSB_AM35X=y
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_PERIPHERAL is not set
> CONFIG_USB_MUSB_OTG=y
> CONFIG_USB_GADGET_MUSB_HDRC=y
> CONFIG_USB_MUSB_HDRC_HCD=y
> # CONFIG_MUSB_PIO_ONLY is not set
> # CONFIG_USB_MUSB_DEBUG is not set

There's a bug on your .config, did you edit by hand ? AM35X doesn't have
DMA support as of today, that's why we have:

config MUSB_PIO_ONLY
	bool 'Disable DMA (always use PIO)'
	depends on USB_MUSB_HDRC
	default USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X

did you disable PIO only ? I know that's a bit fuzzy still, a few
patches will be needed to clean up the entire MUSB Kconfig, I apologize
for that.

-- 
balbi
