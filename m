From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 0/4] omap_udc fixes for omap7xx
Date: Sat, 14 Nov 2009 10:16:12 -0800
Message-ID: <6cb013310911141016n59baae85s62d1272d545defb4@mail.gmail.com>
References: <6cb013310910050748o748d008ch60a85ef504029d9c@mail.gmail.com>
	<20091111003346.GG23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:36534 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZKNSQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 13:16:26 -0500
Received: by pxi10 with SMTP id 10so320393pxi.33
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 10:16:32 -0800 (PST)
In-Reply-To: <20091111003346.GG23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Nov 10, 2009 at 4:33 PM, Tony Lindgren <tony@atomide.com> wrote=
:
>
> * Cory Maccarrone <darkstar6262@gmail.com> [091005 07:51]:
> > The following four patches patch the OMAP UDC subsystem to allow
> > omap7xx-based systems to operate with USB in client mode.
> >
> > Cory Maccarrone (4):
> > =C2=A0 [OMAP] Clocks: Add omap7xx-specific USB clock configuration
> > =C2=A0 [OMAP] omap_udc: Updates for omap7xx IRQs and config
> > =C2=A0 [OMAP] omap_udc: Add clocking and disable vbus sense for oma=
p7xx
> > =C2=A0 [OMAP1] Make ARCH_OMAP850 select ARCH_OMAP_OTG
> >
> > =C2=A0arch/arm/mach-omap1/Kconfig =C2=A0 | =C2=A0 =C2=A01 +
> > =C2=A0arch/arm/mach-omap1/clock.c =C2=A0 | =C2=A0 =C2=A03 ++-
> > =C2=A0arch/arm/mach-omap1/clock.h =C2=A0 | =C2=A0 10 ++++++++++
> > =C2=A0arch/arm/plat-omap/usb.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 20 ++++=
++++++++++------
> > =C2=A0drivers/usb/gadget/omap_udc.c | =C2=A0 19 +++++++++++++++++--
>
> Pushing these as a single patch to omap for-next today. Please
> check and patch as needed.
>
> BTW, had to unwrap some of these manually..
>
> Tony

This looks good, thanks!  I'll need to investigate why the wrapping is
happening -- I've been using gmail on plain-text mode for this.
Perhaps I should use Evolution.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
