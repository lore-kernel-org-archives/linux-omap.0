From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 13:11:40 +0300
Message-ID: <20110627101139.GK2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
	<BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
	<20110627083507.GG2508@legolas.emea.dhcp.ti.com>
	<BANLkTim9Wbxo5U77Vo=FFxYU4vsUps7GMA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0532531153=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTim9Wbxo5U77Vo=FFxYU4vsUps7GMA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: patches@linaro.org, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0532531153==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XlS4q8O07AKt4+K1"
Content-Disposition: inline


--XlS4q8O07AKt4+K1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 27, 2011 at 03:35:41PM +0530, Jaswinder Singh wrote:
> On 27 June 2011 14:05, Felipe Balbi <balbi@ti.com> wrote:
> >> >> > +static struct regulator_consumer_supply sdp4430_vusb_supply =3D
> >> >> > + =A0 =A0 =A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
> >> >
> >> > this should be an array.
> >> Ok, I can make it an array of _one_ element.
> >> Though I am not sure why is that a good thing, or are we to use another
> >> possible VUSB supply on Panda/SDP boards ? =A0Please suggest so that
> >> I can add that too.
> >
> > same comment I gave before to another patch:
> >
> > it makes the diff a lot easier to understand should anyone modify this
> > later. It's also a matter of consistency.
> >
> A quick grep showed otherwise though ...
>=20
> In arch/arm/mach-omap2/
> Total regulators defined                          =3D  71
> Regulators with exactly 1 supply           =3D   58
> Single element non-array definitions     =3D  46/58
> Single element array definitions             =3D  12/58
>=20
> Even if we consider 20% to be norm for consistency, I am not sure it's
> a good one.

the patch which converted all non-array, to array seems to have been
taken yet, then.

> Still many samsung guys piously enclose magic value defines in parenthesi=
s,
> just to maintain 'consistency' !

that's just plain stupidity.

> And, I don't understand how does diff become any easier beyond 2
> elements in the array.

http://marc.info/?l=3Dlinux-omap&m=3D130738044715490&w=3D2

> Sorry for being bitchy, but I am unable to buy any reason other than
> having more than
> one element to use array.

I also seem to recall someone (either Russell or Linus) once explained
why we should never mistake one-element arrays with pointers.
Unfortunately, I fail to find the thread, it's quite old.

--=20
balbi

--XlS4q8O07AKt4+K1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCFdbAAoJEAv8Txj19kN1L/QIAKmc7Rf4qoqsI3npNPhrn+la
+BnpSYfMgMpkSNw06CdzzToADSlibQ7IfVs2rJo3k0S2xxAw5jiMDXSVku9+E8cS
bxZRuup7hGsFmPhE820WhdOEFGYDujWY1Z1I/hHmyIbl8xFfvPsKFH/8erhuqPwb
lt6NghZrbFwoZtowf8IAgz+/HPuRvDIfuZMnBRFMMI9mA56bLFGMoO30MN5Qvbw0
8LzmRUw6Xawd+xBVdHNBx0MbHm6liSMETsF9U16Sc0WJTeM38X+zMp16SxBrjyWN
4fOf+I/p9fBVwS/GqAg6fN6aBPxN4ZDjGy71DRJ2Lqkvt+mtey4em0V/tG1u0i8=
=Mg6C
-----END PGP SIGNATURE-----

--XlS4q8O07AKt4+K1--


--===============0532531153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0532531153==--
