From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] ARM: OMAP3630: Add generic machine descriptor
Date: Fri, 20 Sep 2013 12:42:28 -0500
Message-ID: <20130920174228.GK18721@radagast>
References: <1379693332-10585-1-git-send-email-nm@ti.com>
 <CAOesGMj6G7LeYUJsGpZHxKOjiNrk+1U55QFqcQyTb6_Co+n4zQ@mail.gmail.com>
 <20130920162329.GC18721@radagast>
 <CAOesGMiru=RUHS4XKLL=DC+hxtAJqtcjgd5hPbaccnAfEZ3y0g@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5885813433002191102=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMiru=RUHS4XKLL=DC+hxtAJqtcjgd5hPbaccnAfEZ3y0g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5885813433002191102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline

--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 20, 2013 at 10:16:48AM -0700, Olof Johansson wrote:
> > On Fri, Sep 20, 2013 at 09:19:02AM -0700, Olof Johansson wrote:
> >> On Fri, Sep 20, 2013 at 9:08 AM, Nishanth Menon <nm@ti.com> wrote:
> >> > An alternative approach may be to (for all SoCs):
> >> > 1. define every SoC entry - ti,omap3430 ti,omap3630...
> >> > 2. have a generic omap3_init which uses "if (of_machine_is_compatibl=
e("ti,omap3630"))"
> >> > to invoke the appropriate omap3xxx_init_early.
> >>
> >> Yes, this would be better, but you can do add a DT_MACHINE as in this
> >> patch but have ti,omap3630 as the dt_compat table. Then there's no
> >> need to add runtime checks.
> >
> > I was going to reply that adding of_machine_is_compatible("ti,omap3630")
> > would help in some situations, but guess it's already tainted ;-)
>=20
> Oh, if it's just a few checks, then by all means go down that route. I
> didn't look at the code to see how much it would be.
>=20
> But if a new DT_MACHINE is added, then it should definitely be based
> on ti,omap3630 instead of listing all the boards.

the idea was to CPU compatible property to conditionally enable known
erratas workarounds. In some cases, Revision register can't be trusted,
so instead of creating per-errata DT properties (since that'd be
describing the SW, in a way), I thought of using
of_machine_is_compatible() checks, but that assumes CPU compatible is
"correct".

cheers

--=20
balbi

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPIkEAAoJEIaOsuA1yqREOe8P/31BsNNkb7YJ/cla20N5UA3J
ZRTboYG9pFzFbXQiPPyieytfOIqDGsQ+c/Ur3kLwDx0isALIV36aZKZevwOXHv66
sJJnSLxxPnVoOZ/S17RcTQ3n5Brm/G2OGQ+RHuUIdpELhxc4HG404OKgeSbSDs7s
LtEEs8lT2T4HVtv4pM83/GZcL26ucBsQuRa+82/+qJV7YlRgpyszQtCwwleO1EoL
w7bg2cZzXGDhH+Nd+hD9haTyhzqhh7Bo6s4ihbbQm3VMZBWQNYjXmr/R6YKtnc28
c6NSMIFJ9gZ17Tneph4Sjc+3o0oen0KQ2AgDwyceBc/p4DXuKtThxIPbS6PDOHL6
HUOXZnkByFzBrrtVyJ76rHtUaosXgoCxItdjEUWGdhXwqbgNGaBDYXLg/TouvAEP
a4EWjkASKIgTwKQv4rHZtE5IoltMljnRejtTAseY3s4LslaZycuebPQSR9aJiVX8
9w0uWPz5ijRI4MxBKLrKwtF9BpM9wBSmd9vRpzio2tzNVClKjDA/bGm2kLWDxCHl
cbD9CVUhqO4AjVtmPXjji183QakTn3vsuXFS20kWAJwE47TAfadElJfH8kE3g46b
qb4p4WulxFRtMKs9Et9ZyoDW1vXocYsFw3VhSSDKt3vOlMiwP6aD4EiKU3oa7tOs
eMqcO0zLmI48DvLpK45h
=U/bY
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--


--===============5885813433002191102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5885813433002191102==--
