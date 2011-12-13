From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 18:49:58 +0530
Message-ID: <4EE750FE.5040302@ti.com>
References: <1323781385.1877.75.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47564 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754644Ab1LMNUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:20:04 -0500
Received: by mail-yw0-f49.google.com with SMTP id p34so360448yhp.36
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 05:20:03 -0800 (PST)
In-Reply-To: <1323781385.1877.75.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On Tuesday 13 December 2011 06:33 PM, Tomi Valkeinen wrote:
> Hi,
>
> I'm trying to boot Pandaboard ES with DT, but failing. I've debugged the
> problem enough to see that the bootloader properly loads the DT blob,
> and passes it to the kernel, but the kernel sees only garbage at that
> address, and the devtree->magic check fails in setup_machine_fdt(). I
> presume something overwrites it.
>
> I'm using Pandaboard ES (so omap 4460), Benoit's
> "for_3.3/1_omap_dt_i2c_twl_test" branch, u-boot from Linaro
> (git://git.linaro.org/boot/u-boot-linaro-stable.git master). My u-boot

I used the u-boot from here and it worked fine for me, not sure if its
any different.
git://git.secretlab.ca/git/u-boot devicetree/linaro-stable

> boot-script is below.
>
> Should the setup work? What setup do you have? Any ideas what could be
> wrong?
>
>   Tomi
>
> u-boot boot script:
> -------------------
>
> set netmask 255.255.255.0
> set ipaddr 192.168.1.15
> set serverip 192.168.1.1
>
> set kaddr 0x82000000
> set dtbaddr 0x85000000
>
> set bootcmd 'tftpboot ${kaddr} uImage; tftpboot ${dtbaddr} omap4-panda.dtb; fdt addr ${dtbaddr}; fdt resize; bootm ${kaddr} - ${dtbaddr}'
>
> set bootargs 'console=ttyO2,115200n8 root=/dev/nfs nfsroot=192.168.1.1:/tftpboot/rootfs,tcp,nolock,rsize=1024,wsize=1024 ip=192.168.1.15:::::eth0: vram=36M rootdelay=1 no_console_suspend debug earlyprintk console loglevel=8'
>
> usb start
>
> boot
>
>
> boot log (with added debug prints)
> ----------------------------------
>
> ## Booting kernel from Legacy Image at 82000000 ...
>     Image Name:   Linux-3.2.0-rc1-00014-g4d66c8f-d
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    3664960 Bytes = 3.5 MiB
>     Load Address: 80008000
>     Entry Point:  80008000
>     Verifying Checksum ... OK
> ## Flattened Device Tree blob at 85000000
>     Booting using the fdt blob at 0x85000000
>     Loading Kernel Image ... OK
> OK
>     reserving fdt memory region: addr=9d000000 size=3000000
>     reserving fdt memory region: addr=85000000 size=1000
>     Loading Device Tree to bfef3000, end bfef6fff ... OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> DT phys bfef3000, virt ffef3000
> illegal DT magic
> Warning: Neither atags nor dtb found
>

