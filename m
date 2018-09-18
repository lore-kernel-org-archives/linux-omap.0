From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Date: Tue, 18 Sep 2018 18:16:19 +0200
Message-ID: <20180918181619.2e266f0d@aktux>
References: <20180917052254.12336-1-andreas@kemnade.info>
        <20180917175131.GA104770@dtor-ws>
        <20180917205634.6a320cad@aktux>
        <20180917222345.GA203020@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hF17.lQIoc7SEI58RHUA+gC"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917222345.GA203020@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/hF17.lQIoc7SEI58RHUA+gC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 17 Sep 2018 15:23:45 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Sep 17, 2018 at 08:56:34PM +0200, Andreas Kemnade wrote:
> > Hi Dmitry,
> >=20
> > On Mon, 17 Sep 2018 10:51:31 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >  =20
> > > Hi Andreas,
> > >=20
> > > On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote: =20
> > > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > > the counter will be incremented but the resume callback not called,
> > > > so enumeration and charging will not start properly.
> > > > To avoid that happen, wait and try again later.
> > > >=20
> > > > Practically this happens when the device is woken up from suspend by
> > > > plugging in usb.
> > > >=20
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-=
twl4030-usb.c
> > > > index a44680d64f9b..1f3cf4e48383 100644
> > > > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > > > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > > > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, vo=
id *_twl)
> > > > =20
> > > >  	status =3D twl4030_usb_linkstat(twl);
> > > > =20
> > > > +	/* we might get here too early when runtime is not ready yet
> > > > +	 * and we will get an EACCESS later, so try again later
> > > > +	 */   =20
> > >=20
> > > How exactly can this happen? What disables (and later re-enables)
> > > runtime PM?  =20
> > If the whole resume process is started by plugging in usb, the
> > interrupt will be triggered still in the resume process so that=20
> > runtime resume is not yet possible, pm_runtime_get_sync() returns
> > EACCESS =20
>=20
> I see. This all seems a bit wonky, to be honest. I would expect that the
> driver would have a suspend routine that disables interrupt and also
> configure interrupt for wakeup (enable_irq_wake) and kick bus scanning
> from there instead of aborting interrupt handler...
>=20
well, that seems doable. So there will be a v2.

> >  =20
> > > How can we guarantee that the interrupt will be
> > > re-triggered?
> > >  =20
> > The interrupt will not be re-triggered but the handler will be
> > called at some other places...
> >  =20
> > > > +	if (!pm_runtime_enabled(twl->dev)) {
> > > > +		cancel_delayed_work(&twl->id_workaround_work);
> > > > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > > > +		return IRQ_HANDLED;
> > > > +	}
> > > > + =20
> > ... for example by this delayed work which is already there. =20
>=20
> If we decide to keep this, it should be mod_delayed_work() I think.
>=20
Well, is that valid for the other uses of id_workaround_work() (which
are clearly required)? So there should be a second, independent
cleanup patch for the existing uses?

Regards,
Andreas=20

--Sig_/hF17.lQIoc7SEI58RHUA+gC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluhJNMACgkQfb1qx03i
kyRqSRAAxyTwGaRnx00uUC5GgMf7USmj0z/RC/wWCX+8F/UnZfMyvGl4zgEeE9wd
uXMgKTAJxHCIYSgp106rgo3Y/IbqMZ1t0o27HuD7fmmL2HJ8MuxiZkNYVzkfuKz4
518CgFqBi8q6SP+zAG9TI3bQZJapFbxORoSdRAQGcfFDYeicCx5ObUJh4BRMI5Ey
sX9g237+QzuNMTYvTYa0Vh0HiceHnkAlD2Sj2+jgMFHS7cKitj4bnAajxCNG5y/i
C0OZ4JUsm4d3Ztea7HEi4g5TI97l24sHraYhHbcPZ8twVlccgEwGWrtsuDHclXFc
DFbaeqWRsvLhw0jtdRRtKGiB40cX5W8WAVFTG3HEzBbostSzeln7hGb3vPR1a5rO
4MdWLFTDTFUZyxEfm1CD7qRap7zD/v+choz1ya8kAe/f4plTBdLKWxkC+pZzQRij
nsy+kmC3PSsTH/w6CpBWv883ZiESLijxeLvmP8/69vZTaqhUzRz01tVIvSHtoUgm
lEDSDkMvLpktKUuchUV3tpeyjPU74iuZsCJC+yEIQnYg2TPdOAUKLhpEeGC7NiYr
P7F5xANEntc13a4fotAK6k2pA4Z6ftvseWCvfgavWoUfgIRShk/mfqI8wbctS5Fo
DRaM5Zk/Fp5Nsqy7FsjA0P4pUj/0C+bHkavbqQjl6SxF388tTKk=
=miFt
-----END PGP SIGNATURE-----

--Sig_/hF17.lQIoc7SEI58RHUA+gC--
