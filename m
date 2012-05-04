From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default
 uart pads
Date: Fri, 4 May 2012 10:24:18 -0700
Message-ID: <20120504172417.GE5613@atomide.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
 <87397uhv0q.fsf@ti.com>
 <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60568 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab2EDRYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:24:21 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Russ Dill <russ.dill@gmail.com>

* Raja, Govindraj <govindraj.raja@ti.com> [120424 01:41]:
> On Tue, Apr 24, 2012 at 5:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> > "Govindraj.R" <govindraj.raja@ti.com> writes:
> >
> >> From: "Govindraj.R" <govindraj.raja@ti.com>
> >>
> >> The following commit:
> >> (7496ba3 =C2=A0ARM: OMAP2+: UART: Add default mux for all uarts)
> >> added default pads for all uarts. But not all boards tend to
> >> use all uarts and most of unused uart pins are muxed for
> >> other purpose. This commit breaks the modules which where trying
> >> to use unused uart pins on their boards.
> >>
> >> So remove the default pads adding.
> >
> > I just noticed that this patch breaks runtime PM & wakeups for UART
> > console (at least on 3530/Overo with ttyO2 console.)
> >
> > By removing the pads, the initial device_init_wakeup() is not calle=
d on
> > port init. =C2=A0Without this call serial_omap_pm() disables runtim=
e PM
> > because it checks device_may_wakeup().
> >
> > Since runtime PM was disabled, I manually re-enabled it and then en=
abled
> > wakeups:
> >
> > =C2=A0echo auto > /sys/devices/platform/omap_uart.2/power/control
> > =C2=A0echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/po=
wer/wakeup
> >
> > Then, after enabling auto-suspend timeouts, it seems wakeups are st=
ill
> > not working since the console hangs.
> >
> > Reverting $SUBJECT patch gets things working again.
>=20
> This was decided as part of discussion [1]
>=20
> If we are _reconsidering_ taking this patch [2]
> to dynamically probe uart pins and enable rx wakeup.
>=20
> I can re-work on the patch[2] as per tony's comments[1]
> and re-post it.
=20
Just to follow up on this.. Let's first get things working reliably,
and only then add more PM support.

We absolutely can't revert $SUBJECT because it's known to mess up
at least smsc911x and ehci on zoom3, hsi on n900 and probably
many other things.

=46or the -rc cycle, it seems that [2] is out of question at this point
as too intrusive. If the PM & wakeups are broken in the default cases,
then I suggest we just take few steps back and disable any deeper PM
states in the -rc series.

Regards,

Tony

=20
> [1]:
> http://www.spinics.net/lists/linux-omap/msg68226.html
>=20
> [2]:
> http://www.spinics.net/lists/linux-omap/msg67822.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
