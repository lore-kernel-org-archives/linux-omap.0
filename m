From: "zumeng.chen" <zchen@windriver.com>
Subject: Re: [PATCH RESEND V3 0/3] Watchdog: OMAP3: bootstatus fix and changes
 for the current watchdog framework
Date: Mon, 16 Jul 2012 22:55:53 +0800
Message-ID: <50042B79.10408@windriver.com>
References: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com> <79CD15C6BA57404B839C016229A409A83EA6DFAE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37863 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GPO43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 10:56:29 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA6DFAE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Zumeng Chen <zumeng.chen@windriver.com>, "Hilman, Kevin" <khilman@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2012=E5=B9=B407=E6=9C=8816=E6=97=A5 21:10, Hiremath, Vaibhav wrote:
> On Sun, Jul 15, 2012 at 13:14:03, Zumeng Chen wrote:
>> Hello,
>>
>> The following patches based on the 3.5-rc6 from Wim, which
>> focus on:
>>
>> 1. bootstatus fix for omap3,
>>
>> 2. omap-wdt framework update cater for the current framework
>>     as Shubhrajyoti comments mentioned.
>>
>> V3 changes:
>>
>> 1. New comments updated as Kevin mentioned in the third patch;
>> 2. 3530evm works well,
>>     AM33xx seems work well with the following changes:
>> 	+   if (cpu_is_am335x())
>> 	+       return omap2_prm_read_mod_reg(AM33XX_PRM_DEVICE_MOD,
>> 	+           AM33XX_PRM_RSTST_OFFSET)&  0x7f;
>>     But since some definitions not ready for am33xx, so I don't
>>     give the patch, if they have been updated, feel free to take the=
se.
>>
> Did you test it on any of AM33xx platform?
Yes. I ever did in v2 as follows shown:

The same case works well on am335xevm but with a new patch in
mach-omap2/prcm.c

I'll send it later.

root@ti-omap3:~# uname -a
Linux ti-omap3 3.4.3-00635-g82d1d26-dirty #32 Wed Jul 11 16:02:12 CST
2012 armv7l GNU/Linux
root@ti-omap3:~# dmesg|grep WDT
[ 1.921173] omap_wdt: OMAP WDTimer Rev 0x01: Initial timeout 0sec statu=
s=3D 0x1
root@ti-omap3:~# ./a.out -i 20; for i in `seq 1 20`; do echo $i ; sleep
1;done
Set watchdog interval to 20
Current watchdog interval is 20
Last boot is caused by : Watchdog
Use:
<w>  to kick through writing over device file
<i>  to kick through IOCTL
<x>  to exit the program
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


>   If you use linux-omap/master pr
> linux-next branch as a baseline you should have basic things (except =
hwmod
> data) available.
>
> I will test it and send a patch for this on your behalf (if you are o=
k with
> it).
I'm OK for this, thanks Vaibhav.
>
> Note: Change in convention, cpu_is_am335x() =3D>  soc_is_am335x()
Yes, agreed.

Regards,
Zumeng
> Thanks,
> Vaibhav
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
