From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [GIT PULL]: omap-serial updates for 3.4-rc
Date: Tue, 10 Apr 2012 15:36:49 +0530
Message-ID: <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:47765 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857Ab2DJKHM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 06:07:12 -0400
Received: by obbuo19 with SMTP id uo19so9748130obb.35
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 03:07:10 -0700 (PDT)
In-Reply-To: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

CC'ing Linux-ARM


On Tue, Apr 10, 2012 at 3:32 PM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> Hi Tony,
>
> Please Pull the following omap uart changes.
> Changes basically involves getting rid of cpu checks
> for populating erratas and features and move the same
> from serial.c to omap-serial.c, MVR reg is used to find
> uart versions and errata flags are populated accordingly.
>
> --
> Thanks,
> Govindraj.R
>
> The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b57=
78de9e:
>
> =A0Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
>
> are available in the git repository at:
>
> =A0git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes
>
> for you to fetch changes up to 6c34f211069409ea6d08b900eeaf86ef8efd0d=
ca:
>
> =A0OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24x=
x (2012-04-10 15:14:58 +0530)
>
> ----------------------------------------------------------------
> Govindraj.R (3):
> =A0 =A0 =A0OMAP2+: UART: Remove cpu checks for populating errata flag=
s
> =A0 =A0 =A0OMAP2+: UART: enable tx wakeup bit for wer reg
> =A0 =A0 =A0OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not=
 omap24xx
>
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 13 +---
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A09 +++-
> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
83 ++++++++++++++++++++++++-
> =A03 files changed, 91 insertions(+), 14 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
