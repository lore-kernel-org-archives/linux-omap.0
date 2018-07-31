From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
Date: Tue, 31 Jul 2018 07:28:21 +0200
Message-ID: <20180731072803.61d364db@kemnade.info>
References: <20180730223030.10628-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6834486107980638708=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180730223030.10628-1-drivshin@awxrd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-pwm@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6834486107980638708==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JA0AStxPnw_ti4gDRpyd0Ef"; protocol="application/pgp-signature"

--Sig_/JA0AStxPnw_ti4gDRpyd0Ef
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 30 Jul 2018 18:30:30 -0400
David Rivshin <drivshin@awxrd.com> wrote:

> From: David Rivshin <DRivshin@allworx.com>
>=20
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
>=20
you can of course have my Tested-by:
The version without message runs without trouble in daily use
here on top of 4.17.10. Did also some testing on 4.18-rc7 and I also tested=
 this version.=20

I personally have no strange feeling about what dev_XXX() you have.
I hope not too many other developers spend time to fix this just to find out
that something like this is already in review queue.

Regards,
Andreas

--Sig_/JA0AStxPnw_ti4gDRpyd0Ef
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAltf83UACgkQfb1qx03i
kyQ2+Q/9F0XgRcZOM8KnPeE22QQ02kZkVZkUuiMsiztAC+KM9NU1RLI1ZMAVYf+E
nt95LdISYFWzK+SoevgUI1AbEMjh1x+6TlI+AvY84ks/QJw9OfTyYCdNGdJUNIu+
AJDPqYaOnoTB529KJa4LNjIEmbaJChTHsKUOsenVZ3Xu+50xl9IWLynVTCKR9xlV
+JJWUy6Ka8TykJycd0W9Gc7vhIUcE9uKFCLwldyrkKpUeCc1pQj+stBoU75f2kFS
wptxNhbojxoXFOJhwhdFCHhhi+vSdqrkHAt45D9hLe1Nzm2yAGhkLzuDyrfXfuvy
MEtnVtuPQD3wVDCYQ0r/IYUjf1XHY+PSsWr1vVvOUqUnlXBnPmntKtP1VqvNuASv
MMlFl+INZSWvHNQxYPWU35A727638ZK16N8MDGvajFaCViMoI1GUNTxyAPbVnFdF
n8NZf1fQeqMnW//oKNwD5fHGBl5r1CWLN+6kT4S/6piOo0Mi0LoWPkhZymDsendW
8O/tUB6U/A/cUsbK0g3bXN7ufsLs/GdHtSWUwzlIJoOhjiqyCr623Lo7EK542cPU
JtZtUfFCCWiW4SIhN1MFKNhmvSiOexiHrbW0g+srUfIRkwEY8rJgghvE1AIP4mxR
bnDaul+Qjky7m87CA4TOLhqu6SkwQ8QilSAVRLVTp20QiRm2HWU=
=0SH6
-----END PGP SIGNATURE-----

--Sig_/JA0AStxPnw_ti4gDRpyd0Ef--


--===============6834486107980638708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6834486107980638708==--
