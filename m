From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 14:20:44 +0100
Message-ID: <4EE7512C.6010207@ti.com>
References: <1323781385.1877.75.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab1LMNUr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:20:47 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBDDKltY019129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:20:47 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pBDDKk9Q007195
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:20:46 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBDDKkEK022645
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:20:46 -0600 (CST)
In-Reply-To: <1323781385.1877.75.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi,

On 12/13/2011 2:03 PM, Tomi Valkeinen wrote:
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
> boot-script is below.

I've just sent a patch to add the default DT config for OMAP. It will 
add these config into the OMAP2plus Kconfig.

+	select USE_OF
+	select ARM_APPENDED_DTB
+	select ARM_ATAG_DTB_COMPAT
+	select PROC_DEVICETREE

In theory ARM_APPENDED_DTB and ARM_ATAG_DTB_COMPAT should not be needed 
in your case but only for legacy u-boot.
It should not messed up the DT in case of DT aware uboot, but it worst 
checking if this is the case.

> Should the setup work? What setup do you have? Any ideas what could be
> wrong?

I'm still using a legacy u-boot with the appended option and it works 
fine with the previous config.

Rajendra should use the setting you are trying to use.

Regards,
Benoit

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

