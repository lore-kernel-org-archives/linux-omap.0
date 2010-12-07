From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning
 in mfd/twl-core.c
Date: Tue, 7 Dec 2010 10:48:42 +0100
Message-ID: <20101207094841.GA4772@sortiz-mobl>
References: <alpine.DEB.2.00.1012061734590.13430@utopia.booyaka.com>
 <AANLkTimXPFROMQ_fF4Od-jw3aDY0WZQgc=x14=VcFM3d@mail.gmail.com>
 <alpine.DEB.2.00.1012061839170.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012061839170.13430@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Mon, Dec 06, 2010 at 06:40:38PM -0700, Paul Walmsley wrote:
> On Tue, 7 Dec 2010, Bryan Wu wrote:
>=20
> > On Tue, Dec 7, 2010 at 8:35 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
> > >
> > > Fix the following section mismatch warning when building omap2plu=
s_defconfig:
> > >
> > > WARNING: vmlinux.o(.data+0x47d7c): Section mismatch in reference =
from the variable twl_driver to the function .init.text:twl_probe()
> > >
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > ---
> > > =A0drivers/mfd/twl-core.c | =A0 =A02 +-
> > > =A01 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > > index 35275ba..615cf38 100644
> > > --- a/drivers/mfd/twl-core.c
> > > +++ b/drivers/mfd/twl-core.c
> > > @@ -969,7 +969,7 @@ static int twl_remove(struct i2c_client *clie=
nt)
> > > =A0}
> > >
> > > =A0/* NOTE: =A0this driver only handles a single twl4030/tps659x0=
 chip */
> > > -static int __init
> > > +static int
> >=20
> > I think we might change __init to __devinit.
> >=20
> > > =A0twl_probe(struct i2c_client *client, const struct i2c_device_i=
d *id)
> > > =A0{
> > > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 status;
> > > --
>=20
> That's fine with me.  Samuel et al, Bryan's already done a patch=20
> for this stuff:
>=20
> https://patchwork.kernel.org/patch/367011/
>=20
> so we should use that instead, if you're happy with it.  Samuel, mayb=
e we=20
> could get an ack from you on it?
The twl driver is not OMAP specific, so this should be a separate patch=
 thatI
will merge to my mfd tree.
If you really insist in pushing this through Tony's tree, then please a=
dd my
Acked-by for the mfd part.

Cheers,
Samuel.


--=20
Intel Open Source Technology Centre
http://oss.intel.com/
