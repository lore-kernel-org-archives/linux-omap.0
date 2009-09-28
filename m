From: Amit Kucheria <amit.kucheria@canonical.com>
Subject: Re: [PATCH 0/2] mfd: restoring twl4030 power-off and power-button
 capabilities
Date: Mon, 28 Sep 2009 05:45:41 +0300
Message-ID: <20090928024541.GL32041@smtp.gmail.com>
References: <52241.192.168.10.89.1251990701.squirrel@dbdmail.itg.ti.com>
 <ce9ab5790909251949s71083c3brd625d36653387cc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752848AbZI1Cp4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ce9ab5790909251949s71083c3brd625d36653387cc8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Vimal,

These patches should also be cc'ed to Samuel Ortiz who is the maintaine=
r of
the MFD subsystem where the twl4030 driver resides. It should go upstre=
am
through his tree.

/Amit

On 09 Sep 25, vimal singh wrote:
> Hi Tony,
>=20
> Since there are no comments on these patches, can these go upstream?
> Or, is there something to fix?
>=20
> --vimal
>=20
> On Thu, Sep 3, 2009 at 8:11 AM, vimal singh <vimalsingh@ti.com> wrote=
:
> > This patch series restores the TWL Power-button and Power-off capab=
ilities.
> > Which were removed in "REMOVE OMAP LEGACY CODE" patches.
> >
> > Patches are compile tested only.
> >
> > [PATCH 1/2]: twl4030: register twl4030-pwrbuttonas a child of twl40=
30-core.c
> > [PATCH 2/2]: twl4030: initialization of pm_power_off in twl4030-cor=
e.c
> >
> > Both patches are based on Felipe Balbi's patches posted earlier.
> > http://lkml.org/lkml/2009/2/28/88
> > http://markmail.org/message/ts4if3553qnauket
> >
> > --
> > Vimal
> >
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
-----------------------------------------------------------------------=
--
Amit Kucheria,				 Kernel Developer, Verdurent
-----------------------------------------------------------------------=
--
