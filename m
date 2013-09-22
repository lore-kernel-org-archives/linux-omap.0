From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/9] wilink: add device tree support
Date: Sun, 22 Sep 2013 15:36:32 +0200
Message-ID: <20130922133632.GB8643@amd.pavel.ucw.cz>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
 <1372859132.21065.111.camel@cumari.coelho.fi>
 <20130921122718.GA4431@amd.pavel.ucw.cz>
 <20130921141614.GA21383@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130921141614.GA21383@earth.universe>
Sender: linux-doc-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, mturquette@linaro.org, mark.rutland@arm.com, Felipe Balbi <balbi@ti.com>, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Unfortunately I don't have much time to work on wl1251.  I think =
it
> > > wouldn't be too difficult to do though, so patches are welcome. ;=
)
> > >=20
> > > Maybe you could try to make this change and I could support you i=
f
> > > needed?
> > >=20
> > >=20
> > > > I can offer you my help testing things on pandora and I'm sure =
someone
> > > > here could try it on N900.
> > >=20
> > > I could try it on the N900, if it is still bootable easily with t=
he
> > > mainline. ;)
> >=20
> > 3.11 should be bootable on mainline, including device tree and
> > video. (But excluding some other stuff, like MMC.)
>=20
> I got external MMC (=3D> =B5SD) working with some small modifications=
 of
> the omap3-n900.dts file. I have not yet tried internal MMC, since
> its not important for me at the moment, but I guess its also just a
> small change in the dts file.

Can we get the diff? :-).
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
