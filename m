From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
Date: Thu, 12 Dec 2013 12:27:21 -0600
Message-ID: <20131212182721.GL1939@saruman.home>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <525E8E93.9010503@ti.com> <525E9046.3090209@ti.com>
 <525E943E.3080706@ti.com> <20131017145425.GE11611@gimli>
 <20131203103950.GB26423@xps8300>
 <20131206201530.GA21086@saruman.home>
 <20131209085245.GB5231@xps8300>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7566498481379945954=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131209085245.GB5231@xps8300>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, tony@atomide.com, s.nawrocki@samsung.com, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, Kishon Vijay Abraham I <kishon@ti.com>, grant.likely@linaro.org, devicetree@vger.kernel.org, rob@landley.net, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

--===============7566498481379945954==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline

--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 10:52:45AM +0200, Heikki Krogerus wrote:
> Hi,
>=20
> On Fri, Dec 06, 2013 at 02:15:30PM -0600, Felipe Balbi wrote:
> > On Tue, Dec 03, 2013 at 12:39:50PM +0200, Heikki Krogerus wrote:
> > > On Thu, Oct 17, 2013 at 09:54:26AM -0500, Felipe Balbi wrote:
> > > > On Wed, Oct 16, 2013 at 04:27:26PM +0300, Roger Quadros wrote:
> > > > > On 10/16/2013 04:10 PM, Kishon Vijay Abraham I wrote:
> > > > > Do you know if there are users of dwc3 other than exynos5250 and =
omap5?
> > > > > If not, we should get rid of the old USB PHY altogether.
> > > >=20
> > > > Intel's Baytrail, at least. But they don't use DT.
> > >=20
> > > I don't see any use for the generic-phy when the device is enumerated
> > > from PCI. If dwc3 can live without phys, there should not be any
> > > problem dropping the old USB PHY support.
> >=20
> > yeah, I don't want to drop PHY support, I want to require everybody to
> > provide a PHY, otherwise we have too many options to handle and that's
> > never clean.
>=20
> I have to clarify in case there was a misunderstanding. When I said
> generic-phy I meant drivers/usb/phy/phy-generic.c and I was not
> talking about Kishon's new generic PHY framework.
>=20
> So I was only saying that if the dwc3-pci.c is the only thing that
> needs the old usb phy support, then there should not be any problem
> dropping the support for it.

oh, ok. Got it now, thanks.

--=20
balbi

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqgAJAAoJEIaOsuA1yqREoOQP+gJQBKXpkv0Ur3mbIBZaR7c0
8tjGKhK4W2ExAu5GGBTxzkH+KA8fXwlCQm4JTw2fR6cOtU12KFlZcRyP3w6jiggQ
SjnyxQlE7rXtCSPiH3M8uVWwPkD8pTN2BpJ4n+RFiQtYcImVyoL4LBO3iLvBMmJq
/n8QcFbyBhPmOgSphMVAAillqAWOmLTDNx+WMKkVv8Sko89tyiqmTNTymvqM0Vvq
Y+rmsUjYCbUju9tduPSaVrq3cCFOiX7Nbq7irUGN//hRJ4xVb6+gkDM2x6RE2+JZ
yHvYLepMxMiuNAC2F7ueqSNBPPQzRavWXrwyCZITRIgVhkUzKDe8pQbru74ZGkqh
h664alV7VrkZ/1c2ws0LgDS/GqPHKm4f2KoL+3od5n6v2PO40A2hKLxLHeBz/cQR
pf1BUDMddb05+Vu16Xk+afl2Oj+zp7oCTp1CrZKWDh/ZyFTPUhTcFQwIEXfsBoyF
MgWKZi4mahJx4jMwG7ex5lxAI+3sjiEzPnmfK6DU4alJNPa+OM++Ej1DDSQO03qZ
6GGOuTN+qHWrq3FfeqmdAKVWtgAhFVk3WylkYZaLBKkjBMnlCVSVLEFHuVA5cCMv
K7CDQ4xVv9TXXmGPFDnF463wwanW/dfo+dfDs10AXgOeAYIaEGwAsyp+3YkUOHOk
xwxT7EK2pdBzVXoz99+c
=4U/D
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--


--===============7566498481379945954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7566498481379945954==--
