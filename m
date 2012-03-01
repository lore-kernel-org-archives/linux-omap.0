From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/2] musb runtime_pm fixes
Date: Thu, 1 Mar 2012 13:25:27 +0200
Message-ID: <CANOLnOOQOzfuAnXNoziPze80qpYQhnioW0-ySAhFsC4UO3EiiA@mail.gmail.com>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46609 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757611Ab2CALZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 06:25:29 -0500
In-Reply-To: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, linux-usb@vger.kernel.org

On Sat, Feb 4, 2012 at 7:43 PM, Grazvydas Ignotas <notasas@gmail.com> w=
rote:
> These patches try address isp1704_charger crash in a different way
> than 772aed45b604, which broke runtime_pm for me.
>
> Felipe Contreras, oculd you test isp1704_charger with these?

Ping. These still apply cleanly and are needed to solve musb runtime
PM issues on OMAP3.
I've also done a random ULPI transfer while musb was suspended and it w=
orked.

>
> Grazvydas Ignotas (2):
> =C2=A0usb: musb: fix some runtime_pm issues
> =C2=A0usb: musb: wake the device before ulpi transfers
>
> =C2=A0drivers/usb/musb/musb_core.c | =C2=A0 40 ++++++++++++++++++++++=
+++++++++++-------
> =C2=A0drivers/usb/musb/omap2430.c =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0include/linux/usb/otg.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A03 files changed, 35 insertions(+), 8 deletions(-)
>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
