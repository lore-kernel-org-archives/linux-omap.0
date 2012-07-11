From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH v2 RESEND 0/3] Watchdog: OMAP: bootstatus fix for omap3
 and changes for the current watchdog framework
Date: Wed, 11 Jul 2012 16:10:12 +0800
Message-ID: <4FFD34E4.7060505@windriver.com>
References: <1341819328-3514-1-git-send-email-zumeng.chen@windriver.com> <4FFBACE4.80901@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56013 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab2GKIKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 04:10:41 -0400
In-Reply-To: <4FFBACE4.80901@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com, hvaibhav@ti.com, wim@iguana.be, "Hilman, Kevin" <khilman@ti.com>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul.gortmaker@windriver.com, tony@atomide.com

The same case works well on am335xevm but with a new patch in
mach-omap2/prcm.c

I'll send it later.

root@ti-omap3:~# uname -a
Linux ti-omap3 3.4.3-00635-g82d1d26-dirty #32 Wed Jul 11 16:02:12 CST
2012 armv7l GNU/Linux
root@ti-omap3:~# dmesg|grep WDT
[ 1.921173] omap_wdt: OMAP WDTimer Rev 0x01: Initial timeout 0sec
status=3D 0x1
root@ti-omap3:~# ./a.out -i 20; for i in `seq 1 20`; do echo $i ; sleep
1;done
Set watchdog interval to 20
Current watchdog interval is 20
Last boot is caused by : Watchdog
Use:
<w> to kick through writing over device file
<i> to kick through IOCTL
<x> to exit the program
x

1
2
[snip]
U-Boot SPL 2011.09 (Feb 09 2012 - 15:38:59)
Texas Instruments Revision detection unimplemented


U-Boot 2011.09 (Feb 09 2012 - 15:11:31)

I2C: ready
DRAM: 256 MiB
WARNING: Caches not enabled
=46ound a daughter card connected
NAND: HW ECC Hamming Code selected
256 MiB
MMC: OMAP SD/MMC: 0
Net: cpsw
Hit any key to stop autoboot: 0
U-Boot#

Regards,
Zumeng

=D3=DA 2012=C4=EA07=D4=C210=C8=D5 12:17, Zumeng Chen =D0=B4=B5=C0:
> =D3=DA 2012=C4=EA07=D4=C209=C8=D5 15:35, Zumeng Chen =D0=B4=B5=C0:
>> Hello,
>>
>> The following patches based on the 3.5-rc6 from Wim, which
>> focus on:
>>
>> 1 ) bootstatus fix for omap3,
>>
>> 2 ) omap-wdt framework update cater for the current framework
>>     as Shubhrajyoti comments mentioned.
> I compiled a test case from the following website,
> http://www.lpclinux.com/Blogs/Testing_LPC313x_Linux_Watchdog_Driver
>
> It works well.
>
> root@ti-omap3:/tmp# ./a.out -h
> Usage: ./a.out [options]
> -h --help Display this usage information.
> -d --dev <device_file> Use <device_file> as watchdog device file.
> The default device file is '/dev/watchdog'
> -i --interval <interval> Change the watchdog interval time
> root@ti-omap3:/tmp# ./a.out -i 40;
> Set watchdog interval to 40
> Current watchdog interval is 40
> Last boot is caused by : Watchdog
> Use:
> <w> to kick through writing over device file
> <i> to kick through IOCTL
> <x> to exit the program
> x
> Goodbye !
> watchdog: Omap Watchdog: nowayout prevents watchdog to be stopped!
> watchdog: Omap Watchdog: watchdog did not stop!
> root@ti-omap3:/tmp# for i in `seq 1 30`; do echo $i; sleep 1;done
> 1
> 2
>
> [snip]
>
> I built NOWAYOUT in driver, so it doesn't stop, still going until the
> following
> information:
>
> Texas Instruments X-Loader 1.42
> Starting OS Bootloader...
> No OOB scheme defined for oobsize 0
> OneNAND: 0 kB
> 256 MiB
>
> Regards,
> Zumeng
>> Regards,
>>
>> Zumeng Chen (3):
>>   Watchdog: Omap: Changes for the new watchdog framework
>>   Watchdog: Omap: select watchdog core for framework change
>>   Watchdog: Omap: get the bootstatus for OMAP2Plus
>>
>>  arch/arm/mach-omap2/prcm.c  |    5 +-
>>  drivers/watchdog/Kconfig    |    1 +
>>  drivers/watchdog/omap_wdt.c |  342 ++++++++++++++++----------------=
-----------
>>  drivers/watchdog/omap_wdt.h |    5 +
>>  4 files changed, 133 insertions(+), 220 deletions(-)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
