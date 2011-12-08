From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] amp/omap: add a remoteproc driver
Date: Thu, 8 Dec 2011 09:01:14 -0800
Message-ID: <20111208170114.GZ31337@atomide.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-5-git-send-email-ohad@wizery.com>
 <CAK=WgbZvH3eiouryKDenC_x0LdDcHFuumhfoeY4ueiwT5r0cxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbZvH3eiouryKDenC_x0LdDcHFuumhfoeY4ueiwT5r0cxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rusty Russell <rusty@rustcorp.com.au>, Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [111207 23:26]:
> Hi Tony,
>=20
> On Tue, Oct 25, 2011 at 11:48 AM, Ohad Ben-Cohen <ohad@wizery.com> wr=
ote:
> > Add a remoteproc driver for OMAP4, so we can boot the dual-M3 "Duca=
ti"
> > and DSP subsystems.
> >
> > Use the omap_device_* API to control the hardware state, and utiliz=
e
> > the OMAP mailbox to interrupt the remote processor when a new messa=
ge
> > is pending (the mailbox payload is used to tell it which virtqueue =
was
> > the message placed in).
> >
> > Conversely, when an inbound mailbox message arrives, tell the remot=
eproc
> > core which virtqueue is triggered.
> >
> > Later we will also use the mailbox payload to signal omap-specific
> > events like remote crashes (which will be used to trigger remotepro=
c
> > recovery) and power management transitions. At that point we will a=
lso
> > extend the remoteproc core to support this.
> >
> > Based on (but now quite far from) work done by Fernando Guzman Lugo
> > <fernando.lugo@ti.com> and Hari Kanigeri <h-kanigeri2@ti.com>.
> >
> > Designed with Brian Swetland <swetland@google.com>.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > Cc: Brian Swetland <swetland@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Greg KH <greg@kroah.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > =C2=A0arch/arm/plat-omap/include/plat/remoteproc.h | =C2=A0 56 ++++=
++
> > =C2=A0drivers/amp/remoteproc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 21 +++
> > =C2=A0drivers/amp/remoteproc/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
> > =C2=A0drivers/amp/remoteproc/omap_remoteproc.c =C2=A0 =C2=A0 | =C2=A0=
248 ++++++++++++++++++++++++++
> > =C2=A0drivers/amp/remoteproc/omap_remoteproc.h =C2=A0 =C2=A0 | =C2=A0=
 69 +++++++
> > =C2=A05 files changed, 397 insertions(+), 1 deletions(-)
> > =C2=A0create mode 100644 arch/arm/plat-omap/include/plat/remoteproc=
=2Eh
> > =C2=A0create mode 100644 drivers/amp/remoteproc/omap_remoteproc.c
> > =C2=A0create mode 100644 drivers/amp/remoteproc/omap_remoteproc.h
>=20
> I'm about to add this to linux-next (minus the 'amp' wording); can I
> please have your Acked-by for this (at least for the plat-omap change=
) ?

The platform init code looks OK to me. Please also start considering
how to do the DT bindings for it. For patches 4 & 5:

Acked-by: Tony Lindgren <tony@atomide.com>
