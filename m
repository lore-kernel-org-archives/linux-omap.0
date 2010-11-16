From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 0/3] OMAP: wd_timer: update integration code to use new
 hwmod changes
Date: Tue, 16 Nov 2010 16:07:34 +0530
Message-ID: <AANLkTi=nKOL_iojREzfjA-G1hFR1QzTMJ_1WrGR2_FZo@mail.gmail.com>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41754 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932793Ab0KPKiQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 05:38:16 -0500
Received: by mail-iw0-f176.google.com with SMTP id 33so675956iwn.35
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 02:38:15 -0800 (PST)
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

Thanks for the series.

On Tue, Nov 16, 2010 at 15:55, Paul Walmsley <paul@pwsan.com> wrote:
> Update the OMAP watchdog timer integration code to take advantage of
> the new hwmod upgrades added by the "OMAP2+: hwmod core upgrades for
> 2.6.38: first set" series, posted previously. =A0So that series needs
> to be applied before these patches.
>
> Charu, it would be great if you could take a look at these.

It looks fine for me.

-V Charulatha

>
> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.
>
>
> - Paul
>
> ---
>
> wdt_2.6.38
> =A0 text =A0 =A0data =A0 =A0 bss =A0 =A0 dec =A0 =A0 hex filename
> 5709076 =A0470560 5608992 11788628 b3e154 vmlinux.omap2plus_defconfig=
=2Eorig
> 5708892 =A0470560 5608992 11788444 b3e09c vmlinux.omap2plus_defconfig=
=2Epatched
>
> Paul Walmsley (3):
> =A0 =A0 =A0OMAP2+: wd_timer: separate watchdog disable code from the =
rest of mach-omap2/devices.c
> =A0 =A0 =A0OMAP2+: wd_timer: disable on boot via hwmod postsetup mech=
anism
> =A0 =A0 =A0OMAP: wd_timer: remove old, dead probing code
>
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 -
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 64 =
+---------------------------
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 18 ++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0 =A06 ++-
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A06 ++-
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A06 ++-
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A06 ++-
> =A0arch/arm/mach-omap2/wd_timer.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 54 ++=
++++++++++++++++++++++
> =A0arch/arm/mach-omap2/wd_timer.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 ++=
+++++
> =A0arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 38 =
-----------------
> =A010 files changed, 108 insertions(+), 109 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/wd_timer.c
> =A0create mode 100644 arch/arm/mach-omap2/wd_timer.h
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
