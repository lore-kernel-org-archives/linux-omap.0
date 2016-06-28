From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 5/5] regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs
Date: Tue, 28 Jun 2016 12:45:48 +0100
Message-ID: <20160628114548.GB24982@dell>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
 <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
 <20160627165930.GC17217@sirena.org.uk>
 <20160628111206.GB17585@dell>
 <20160628111343.GC17585@dell>
 <57725E67.8020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57725E67.8020705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, Keerthy wrote:

>=20
>=20
> On Tuesday 28 June 2016 04:43 PM, Lee Jones wrote:
> > On Tue, 28 Jun 2016, Lee Jones wrote:
> >=20
> > > On Mon, 27 Jun 2016, Mark Brown wrote:
> > >=20
> > > > On Fri, Jun 24, 2016 at 01:58:11PM +0530, Keerthy wrote:
> > > > > From: Tero Kristo <t-kristo@ti.com>
> > > > >=20
> > > > > Some versions of tps65218 do not seem to support poweroff mod=
es properly
> > > > > if DCDC3 regulator is shut-down. Thus, keep it enabled even d=
uring
> > > > > poweroff if the version info matches the broken silicon revis=
ion.
> > > >=20
> > > > This is fine but depends on the MFD bit so needs to wait for th=
at to be
> > > > reviewed.
> > >=20
> > > I think it's fine for you to take this.
> >=20
> > Tell a lie.  I just saw the struct member added in the other patch.
>=20
> Oh yes! I will wait for this series to get in completely. I guess mor=
e
> re-basing would be needed on the other patch.

Not if they all go in via Mark's tree.

> > Do you want to take the set?  If so, I'll just Ack my bit.
> >=20
> > For the MFD changes in this patch:
> >    Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
