From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and changes
 for the current watchdog framework
Date: Mon, 9 Jul 2012 12:46:30 +0800
Message-ID: <4FFA6226.9010605@windriver.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44556 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2GIEu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 00:50:27 -0400
In-Reply-To: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com

The changes have been validated on omap3530evm

Normal reboot
root@ti-omap3:~# dmesg|grep WDT
omap_wdt: OMAP WDTimer Rev 0x31: Initial timeout 0sec status=3D 0x0
root@ti-omap3:~#

root@ti-omap3:~# echo 1 >/dev/watchdog
Boot from WDT

root@ti-omap3:~# dmesg|grep WDT
omap_wdt: OMAP WDTimer Rev 0x31: Initial timeout 0sec status=3D 0x1
root@ti-omap3:~#

Regards,
zumeng
=D3=DA 2012=C4=EA07=D4=C209=C8=D5 12:39, Zumeng Chen =D0=B4=B5=C0:
> Hello,
>
> The following patches based on the 3.5-rc6 from Wim, which
> are based on:
>
> 1 ) bootstatus fix for omap3,
>
> 2 ) omap-wdt framework update cater for the current framework
>     as Shubhrajyoti comments mentioned.
>
> Regards,
> Zumeng
>
>   Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
>
> Zumeng Chen (3):
>       Watchdog: Omap: Changes for the new watchdog framework
>       Watchdog: Omap: select watchdog core for framework change
>       Watchdog: Omap: get the bootstatus for OMAP2Plus
>
>  arch/arm/mach-omap2/prcm.c  |    5 +-
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++-----------------=
----------
>  drivers/watchdog/omap_wdt.h |    5 +
>  4 files changed, 133 insertions(+), 216 deletions(-)
>
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
