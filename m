From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 0/5] Add support for Fujitsu USB host controller
Date: Fri, 30 Jan 2015 10:38:15 -0600
Message-ID: <20150130163815.GG15318@saruman.tx.rr.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <20150127152250.GB13776@saruman.tx.rr.com>
 <20150129162312.GH21217@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150129162312.GH21217@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Sneeker Yeh <sneeker.yeh@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 29, 2015 at 10:23:12AM -0600, Felipe Balbi wrote:
> On Tue, Jan 27, 2015 at 09:22:50AM -0600, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Sun, Jan 25, 2015 at 04:13:23PM +0800, Sneeker Yeh wrote:
> > > These patches add support for XHCI compliant Host controller found
> > > on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
> > > The first patch is to add Fujitsu glue layer of Synopsis DesignWare U=
SB3 driver
> > > and last four patch is about quirk implementation of errata in Synops=
is
> > > DesignWare USB3 IP.
> > >=20
> > > Patch 1 introduces a quirk with device disconnection management neces=
sary
> > > Synopsys Designware USB3 IP with versions < 3.00a and hardware config=
uration
> > > DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1. It solves a problem where with=
out the
> > > quirk, that host controller will die after a usb device is disconnect=
ed from
> > > port of root hub.
> > >=20
> > > Patch 2 is to set Synopsis quirk in xhci platform driver based on xhc=
i platform
> > > data.
> > >=20
> > > Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis Design=
Ware USB3
> > > IP core driver.
> > >=20
> > > Patch 4 introduces using a quirk based on a errata of Synopsis
> > > DesignWare USB3 IP which is versions < 3.00a and has hardware configu=
ration
> > > DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1, which cannot be read from soft=
ware. As a
> > > result this quirk has to be enabled via platform data or device tree.
> > >=20
> > > Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare=
 USB3 IP
> > > driver.=20
> > >=20
> >=20
> > Mathias, let me know how you want to handle this. Either I take them
> > all, or you take them all. What do you prefer ?
>=20
> Mathias ?

Mathias, a reminder on this series.

--=20
balbi

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUy7N3AAoJEIaOsuA1yqREvRgP/13uuV8wRPJp+0TdNVub9YCX
VNoPhoWQrf9NJbw/p6LQCWEkU1JEYrPPEaZqOLcDzOKi8yv5VAduovx+TBK/Zs36
kNzgQ2j/dJXz87sN/DjhhaB47HkqGsg7UvoWs6dzWnYFRxdcoBj/6AEysXJD+Zlj
RLaQAeyilowYVdinEjQLPGr/GsdrwuJtRJL3SN4H1FWyGT1+ddDwzO22+ZH0M1QI
IcyO98qug8GzvKB4Cnr+jUnhcsNQFVfbt/Ruvd4Q/B1pAZysX/hSVaLaoenilvbj
ZkXa0soszqfiUE8Foo+IcPcm/IHMmfxxfh4JmU69RWgT1Mk0bUhdNpxWxnqueRW5
sPIuNSe0HjaFEqcpKHDFtKoYOiqIkOAzndsVWrk6rOHslzbE47KN5P2Y42LAjehc
0GZIi43/OLDiZMuAKRK8/do+UeL/fa/KaMXmZtTJoxiGVEmRwyQylY2mMi4i1ZSU
PkJLxluKqrhMaoMnTu4BPEpwmVALQWNkP9yG6Xf/N1VQrAJokRgFVE6hZCTfHpBc
wj3zq9Nrn1X4OvsvBNw6Rl52VtRS2q/4R5IvikzO4t+MIBVUZYa6/MWAOb3Y2Hst
MMZy6dt0bFpet3+R09elKWacFdQ0rYmJd/4+dQvQVz0fXegEPDQ6NGnzZsnEn5YB
0GGy7sz/dro84gi8Ke2z
=40qE
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
