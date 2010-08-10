From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] [omap1] Bluetooth device code common to HTC
 smartphones
Date: Tue, 10 Aug 2010 09:36:27 +0300
Message-ID: <20100810063626.GE32480@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
 <20100804101507.GG9881@atomide.com>
 <AANLkTikGA9-TCM7v+_yivBYtxiX3ByJ7_ub1FOP0LgBO@mail.gmail.com>
 <20100809074300.GB32480@atomide.com>
 <AANLkTinQ+50aFPj6M0yEnE_nemamnBb8=emD--VZ_hsG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57085 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0HJGgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 02:36:32 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinQ+50aFPj6M0yEnE_nemamnBb8=emD--VZ_hsG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100809 20:21]:
> On Mon, Aug 9, 2010 at 12:43 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100808 20:22]:
> >> On Wed, Aug 4, 2010 at 3:15 AM, Tony Lindgren <tony@atomide.com> w=
rote:
> >> > * Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> >> >> This change adds in a bluetooth controld driver/rfkill
> >> >> interface to the serial bluetooth controller found on many
> >> >> HTC smartphones such as the HTC Herald and HTC Wizard.
> >> >
> >> > To me it looks like most of this should be in drivers/bluetooth/=
omap7xx.c
> >> > or something like that. Then you can just pass it the gpio numbe=
rs in
> >> > the platform_data.
> >> >
> >>
> >> Not sure I agree that it fits there. =C2=A0The driver isn't really=
 a
> >> bluetooth driver -- it's really just an RFKILL interface, and some
> >> code to toggle UART clocks on and off, plus GPIO work on a
> >> board-specific level. =C2=A0In principle, the gpios could be set a=
nd the
> >> clocks enabled in the board files, and this driver wouldn't be
> >> necessary to get working bluetooth (as we'd use hciattach on
> >> /dev/ttyS*). =C2=A0But then, we can't toggle it off for power savi=
ng.
> >> Maybe a better place would be plat-omap/? =C2=A0But it really is m=
ore
> >> specific to these HTC boards, not the architecture itself.
> >
> > Hmm well what we've used earlier is to set something like set_power
> > function pointer in the platform data, then call that in the driver
> > if set. But in this case the driver is 8250.c, so let's not mess
> > with that..
> >
> > This issue should get properly solved with the omap specific serial
> > driver once we get that merged as then we can have hooks for set_po=
wer
> > in addition to cutting serial clocks when idle.
> >
> >> So really, the only point of this driver is to be able to power on=
 and
> >> off the external bluetooth chip, which is why I submitted it as he=
lper
> >> code to the board files.
> >
> > Yeah. Can you take a look at the omap specific serial driver to get
> > it working on omap1?
> >
> > Then you can have your GPIO functions set in the board-*.c file
> > as set_power or similar, and the UART driver can idle properly.
> >
>=20
> I can look at it.  Where is the code for that, arch/arm/mach-omap2/se=
rial.c?

It's been floating on the list for a while now, here's the latest
version:

http://www.spinics.net/lists/linux-omap/msg31786.html

Probably doing the platform data initialization is the biggest
part that needs to be done for omap1, the driver itself should not
need much changes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
