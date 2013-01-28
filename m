From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Mon, 28 Jan 2013 11:43:48 +0000
Message-ID: <51066474.9030701@mimc.co.uk>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com> <20130126084604.GB8754@arwen.pp.htv.fi> <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:48316 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753221Ab3A1Lnt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 06:43:49 -0500
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28/01/13 10:34, Mohammed, Afzal wrote:
> Hi,
> 
> On Sat, Jan 26, 2013 at 14:16:04, Balbi, Felipe wrote:
>> On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> 
>>> * am335xbone: hangs after "Starting kernel"
>>>   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
>>>   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
>>>   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
>>
>> FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
>> without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
>> to help my bone, no matter if I had appended DTB or not.
> 
> Following patch with low level debug may help to find where the issue is,
> (my observation is that it boots with mainline u-boot)
> 
> Regards
> Afzal
> 
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 41b581f..178a411 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -117,6 +117,10 @@ config SOC_AM33XX
>         select CPU_V7
>         select MULTI_IRQ_HANDLER
>         select COMMON_CLK
> +       select MACH_AM335XEVM
> +
> +config MACH_AM335XEVM
> +       bool
> 
>  config OMAP_PACKAGE_ZAF
>         bool
> 

I can confirm that this patch works with EARLY_PRINTK and DEBUG_LL enabled (current mainline kernel
and u-boot), and the following .config changes:-

$ diff .config.omap2plus_defconfig .config
505c505,508
< # CONFIG_ARM_APPENDED_DTB is not set
---
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
2659c2662,2665
< # CONFIG_DEBUG_LL is not set
---
> CONFIG_DEBUG_LL=y
> CONFIG_DEBUG_LL_UART_NONE=y
> # CONFIG_DEBUG_ICEDCC is not set
> # CONFIG_DEBUG_SEMIHOSTING is not set
2660a2667
> CONFIG_EARLY_PRINTK=y

Boot log
--------
Filename '/nanobone/uImage-dtb'.
Load address: 0x80000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########
         627 KiB/s
done
Bytes transferred = 3946799 (3c392f hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux 3.8.0-rc5-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3946735 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc5-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot
2012.11-git-00497-ge48bf89) ) #9 SMP Mon Jan 28 11:34:19 GMT 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c07c7040, node_mem_map c0d27000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f30000 s12992 r8192 d15680 u36864
[    0.000000] pcpu-alloc: s12992 r8192 d15680 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk debug root=/dev/mmcblk0p2 ro
rootfstype=ext2 rootwait

<snip>

[    1.702800] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    1.713088] Random MACID = 56:e9:38:ee:af:e4
[    1.723695] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.735470] Waiting for root device /dev/mmcblk0p2...

Still no support for rootfs on MMC, but hopefully that won't be long ??

Regards
Mark J.
