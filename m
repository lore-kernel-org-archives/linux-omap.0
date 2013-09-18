From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Wed, 18 Sep 2013 11:25:39 -0500
Message-ID: <20130918162539.GK21559@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309172128.42514@pali> <20130918014942.GD19817@radagast>
 <201309181020.15245@pali>
 <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
 <20130918133025.GB2953@amd.pavel.ucw.cz>
 <CAAwP0s0nGthkm9Bp1ug23Rtz6-sbR60FFTSfd-Cj9wKMU0RBEA@mail.gmail.com>
 <20130918142203.GD3748@amd.pavel.ucw.cz>
 <20130918143537.GA4914@amd.pavel.ucw.cz>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1351415869492566942=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130918143537.GA4914@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, freemangordon@abv.bg, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1351415869492566942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline

--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 18, 2013 at 04:35:37PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > gave feedback. If the sender doesn't want to take his feedback into
> > > account and prefer to send pretty insulting emails instead that is his
> > > choice but I would say that is this not the greatest approach to get
> > > your code merged (to say the least).
> >=20
> > Clearly not. But Pali found bug in code Felipe should
> > maintain. Instead of "thank you for bug report, I applied this one
> > line of your code to fix it", Pali got "new patch, new email" for his
> > efforts. That is how you train dogs, not how you should treat kernel
> > contributors.
> >=20
> > Now, it is possible that Felipe just has problems with english, as he
> > called me piece of wood in https://lkml.org/lkml/2013/9/17/476 , but
> > he appears more arogant than usual over email.
>=20
> Actually he called me "piece of wood with garbage in it". I guess I
> have right to be offended. I'm baby in the next email. Hmm.

what a baby. Grow up dude, just grow up. I said your commit log has
garbage which shouldn't be there (there was a typo you're instead of
your).

--=20
balbi

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOdQDAAoJEIaOsuA1yqREfNUQAJaBs9wwWysCfsisO3kneU58
9E/8dXHmNPlUzBE2oRhB72clc8gphAc1XVCoNoFiiHI7mWJx0Gzq2/gQarS41AmE
7/QtbS+o847kfTS66nHb1XQV+QgPBzBrPWyyNKVaSIGx2NnUCXXaunlZM/dZcj3g
SBQYy7fcJDy2s9Q81JT16i5mbFuFjJg5qIywTdV+VA0fFE3O0DeNxyutPbYmb/Ec
WTVDj3BgiK+ytHAwf9j4em2FpPXVvACED0vEB74bbOcylzPobhAmh2z6bBg9TllZ
lS6+AonZEW0hqcdlsPmlGbG6LDB+LVLU9ZAiHISpN+1FF9t6AVDXXFPmMBLP6y2s
3P4lZ0WKcS27V7c2pRlUqMpKgqoEmFD1dAMwtdjg9dSF8ggMQNyNOSht0p9eiSCM
u3sa7lGA29BDFDMyn8fzjr/YMkJNdQWfBK9uiDclmIztf9rG7Sc8GCSVdn/CQfsG
FywYj+ddhq6ad6Nkb7d9iBzZazY7B34YGCffzkWiq4BXCGJEPvPFlDyFxJh26SdR
iCJArWj/wRBypBb0K3mhJw/8wWESnd48H226pJIxK9R9hI2+Kd/HAB9JEK3oVmBD
Ln7TyFu/ezYY4rHsOPA1u1yaetjKmYQbIltZuVt0UTpEZGjBltZKb9IW87N8YXV4
sEqt4kz3xMHfkXzsByCf
=z/YG
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--


--===============1351415869492566942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1351415869492566942==--
