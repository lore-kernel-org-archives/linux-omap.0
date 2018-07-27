From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
Date: Fri, 27 Jul 2018 13:00:06 +0200
Message-ID: <20180727110006.GC20233@amd>
References: <20180726133658.23902-1-drivshin@awxrd.com>
 <20180726185426.GA3546@lenoch>
 <20180726163705.4981d44a.drivshin@awxrd.com>
 <20180727071901.GA10846@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0623898332303718815=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180727071901.GA10846@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pwm@vger.kernel.org, David Rivshin <drivshin@awxrd.com>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0623898332303718815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-07-27 09:19:01, Ladislav Michl wrote:
> On Thu, Jul 26, 2018 at 04:37:05PM -0400, David Rivshin wrote:
> > On Thu, 26 Jul 2018 20:54:26 +0200
> > Ladislav Michl <ladis@linux-mips.org> wrote:
> >=20
> > > On Thu, Jul 26, 2018 at 09:36:58AM -0400, David Rivshin wrote:
> > > > From: David Rivshin <DRivshin@allworx.com>
> > > >=20
> > > > If a pwm-omap-dmtimer is probed before the dmtimer it uses, the pla=
tform
> > > > data won't be set yet.
> > > >=20
> > > > Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer =
pdata")
> > > > Cc: <stable@vger.kernel.org> # 4.17+
> > > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > > ---
> > > > Changes in v2:
> > > > * Added Pavel's Acked-by/Tested-by [1]
> > > >=20
> > > > [1] https://lkml.org/lkml/2018/7/16/346
> > > >=20
> > > >  drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-=
dmtimer.c
> > > > index 665da3c8fbceb..d3d7ea7a53146 100644
> > > > --- a/drivers/pwm/pwm-omap-dmtimer.c
> > > > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > > > @@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platfo=
rm_device *pdev)
> > > > =20
> > > >  	timer_pdata =3D dev_get_platdata(&timer_pdev->dev);
> > > >  	if (!timer_pdata) {
> > > > -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> > > > -		ret =3D -EINVAL;
> > > > +		dev_info(&pdev->dev,
> > > > +			 "dmtimer pdata structure NULL, deferring probe\n"); =20
> > >=20
> > > This seems to be a bit verbose for EPROBE_DEFER case. Could we either=
 remove
> > > it as it is done later in pdata->request_by_node(timer) failure case =
or at
> > > least make it dev_dbg? Otherwise thank you and with mentioned change
> > > Acked-by: Ladislav Michl <ladis@linux-mips.org>
> >=20
> > Hi Ladislav, thanks for the review.
> >=20
> > I had grepped through other drivers and found no consistent pattern. So=
me
> > places used dev_err still, others reduced to one of dev_{warn,info,dbg}=
,=20
> > and others no message at all. Some messages mentioned they are deferrin=
g=20
> > the probe, other didn't. I was already getting a couple of dev_info fro=
m=20
> > the pinctrl core code, so I went that way. I figured the message might =
be
> > useful to someone, but I don't feel strongly.
>=20
> Well, pinctrl probe deferal message is a bit annoying. It really does not
> tell us much as long as pins are correctly configured and in case they are
> not it is useless as well :)
>=20
> > I personally would lean to dev_dbg if you think dev_info is too harsh,=
=20
> > just in case someone's board suddenly isn't working after upgrade. But=
=20
> > I'm certainly willing to remove the message entirely if you feel strong=
ly,
> > or anyone else cares to weigh in.
>=20
> I'm fine with dev_dbg as well.

Looks good to me, too.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlta+zYACgkQMOfwapXb+vIy3gCdH2G3FQf8ALe1Fo9v4RRc7uIr
oVIAn2ONJkQxCQfkoIl0qgLGSD/svq8g
=W/HL
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--


--===============0623898332303718815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0623898332303718815==--
