From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Wed, 9 Feb 2011 11:15:58 +0530
Message-ID: <82c254dc5a3a4a405b25350e1ef3240e@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org><36192288611a2912eca9abc99a4353ff@mail.gmail.com><AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com><9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
 <AANLkTiknZ1VrA_OuqY=0AihNWiEdMkHA_zyVKQLg70+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57204 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815Ab1BIFqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 00:46:00 -0500
Received: by mail-wy0-f181.google.com with SMTP id 22so6731577wyf.12
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 21:45:59 -0800 (PST)
In-Reply-To: <AANLkTiknZ1VrA_OuqY=0AihNWiEdMkHA_zyVKQLg70+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Tuesday, February 08, 2011 11:11 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; Jean Pihet-
> XID; linux-omap@vger.kernel.org; Nicolas Pitre
> Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility
> fixes
>
> Hi Santosh,
>

[...]

> I'm still having problems testing basic power management...
>
> I'm using this config:
> http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config
>
> ... and Kevin's pm tree with my patches on top.
>
>
> However, even building without CONFIG_THUMB2_KERNEL, Beagle xM
> doesn't
> seem to suspend properly:
>
> Linux xm-1 2.6.38-rc2+ #19 SMP Tue Feb 8 14:02:24 GMT 2011 armv7l
> GNU/Linux
>
> #
> # [  302.446228] SysRq : Changing Loglevel
> [  302.449951] Loglevel set to 9
> echo mem >/sys/power/state &
> [1] 545
> # [  306.525177] PM: Syncing filesystems ... done.
> [  308.989715] mmc0: card 1234 removed
> #
> #
> #
> #
> #
> # jobs
> [1]+  Running                 echo mem > /sys/power/state &
> #
>
> The SD card gets suspended, but nothing else seems to happen, and I
> can't resume the system.
>
> Am I doing something wrong?
>
MMC suspend is broken. I use ramdisk-ext3 or NFS for my testing

Regards,
santosh
