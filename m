From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY
Date: Tue, 17 Sep 2013 10:45:09 -0500
Message-ID: <20130917154509.GJ15645@radagast>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-2-git-send-email-kishon@ti.com>
 <52319912.8030203@ti.com>
 <CAFp+6iE+xbSWWp2bNc5MRSUrA4Fi6qVU4vhR4+mtZHZGidkMGg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6693026817336966748=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFp+6iE+xbSWWp2bNc5MRSUrA4Fi6qVU4vhR4+mtZHZGidkMGg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Kishon Vijay Abraham I <kishon@ti.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, george.cherian@ti.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson>
List-Id: linux-omap@vger.kernel.org

--===============6693026817336966748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UK1lfQXsnwKrySH9"
Content-Disposition: inline

--UK1lfQXsnwKrySH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2013 at 04:17:08PM +0530, Vivek Gautam wrote:
> On Thu, Sep 12, 2013 at 4:06 PM, Roger Quadros <rogerq@ti.com> wrote:
> > Hi Kishon,
> >
> > On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> >> There can be systems which does not have a external usb_phy, so get
> >> usb_phy only if usb-phy property is added in the case of dt boot or if
> >> platform_data indicates the presence of PHY. Also remove checking if
> >> return value is -ENXIO since it's now changed to always enable usb_phy=
 layer.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/usb/dwc3/Kconfig         |    1 +
> >>  drivers/usb/dwc3/core.c          |   60 +++++++++++++++++------------=
---------
> >>  drivers/usb/dwc3/platform_data.h |    1 +
> >>  3 files changed, 28 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >> index f969ea2..cfc16dd 100644
> >> --- a/drivers/usb/dwc3/Kconfig
> >> +++ b/drivers/usb/dwc3/Kconfig
> >> @@ -2,6 +2,7 @@ config USB_DWC3
> >>       tristate "DesignWare USB3 DRD Core Support"
> >>       depends on (USB || USB_GADGET) && GENERIC_HARDIRQS && HAS_DMA
> >>       depends on EXTCON
> >> +     select USB_PHY
> >>       select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
> >>       help
> >>         Say Y or M here if your system has a Dual Role SuperSpeed
> >> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> index 474162e..428c29e 100644
> >> --- a/drivers/usb/dwc3/core.c
> >> +++ b/drivers/usb/dwc3/core.c
> >> @@ -387,16 +387,38 @@ static int dwc3_probe(struct platform_device *pd=
ev)
> >>       if (node) {
> >>               dwc->maximum_speed =3D of_usb_get_maximum_speed(node);
> >>
> >> -             dwc->usb2_phy =3D devm_usb_get_phy_by_phandle(dev, "usb-=
phy", 0);
> >> -             dwc->usb3_phy =3D devm_usb_get_phy_by_phandle(dev, "usb-=
phy", 1);
> >> +             if (of_property_read_bool(node, "usb-phy")) {
> >> +                     dwc->usb2_phy =3D devm_usb_get_phy_by_phandle(de=
v,
> >> +                             "usb-phy", 0);
> >> +                     if (IS_ERR(dwc->usb2_phy))
> >> +                             return PTR_ERR(dwc->usb2_phy);
> >> +                     dwc->usb3_phy =3D devm_usb_get_phy_by_phandle(de=
v,
> >> +                             "usb-phy", 1);
> >> +                     if (IS_ERR(dwc->usb3_phy))
> >> +                             return PTR_ERR(dwc->usb3_phy);
> >
> > Some DWC3 instances use only usb2_phy. e.g. on DRA7 the 2nd dwc3 instan=
ce doesn't use usb3_phy.
> > This needs to be a valid case and driver shouldn't error out.
>=20
> So, i think adding flexibility to DWC3 to have either
> usb2-phy/usb3-phy or both of them seems to be valid point.
> Any suggestions ?

I've gone through that. There's no easy way to make USB3 PHY optional.

For platforms which actually have the USB3 side of things, not
initializing the PHY kills dwc3.

I've been trying to understand what it is that the USB3 PHY generates
and gets backfed into dwc3, but so far no luck.

I even have a patch for that, which I have dropped when I found out
about this problem.

--=20
balbi

--UK1lfQXsnwKrySH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOHkFAAoJEIaOsuA1yqREI+QP+wXTnOtz61O0X2jqImlVG463
mjX+fp5xf82wkFmsaVHzvnji1iqdc7ArvOjejIlhDpvtaA9TftAGCvS5OKYFBAjy
Vf4ZtbFmw0gh82MOcmHQCWibV+5M9MiwYf16zsZXFXLUPWCm+VvShrZR2ESEJ1Xe
sruFZWLFf8xFGt8HpWhrQUQejnvaBVEQDhjuF4muGu8c3TYsxLmSr/CqymZm9FMH
J2z7QkbAYHFi6sPBFJbPPoHrSLZzbmeAFYQdyZ/GJYjiu9XKvb2DLewbkBXDm/fT
re8PcDg0ddG05eOG9PSd7nuzyVw3c5EcpjXU5UAHNAM+lLnFQ6ajizTeMH2YDEAA
CXDuVfq6QYgQ69xO3JejubFrvc6EF7dqjG30fpm2YALLtKnbzfFSWOKbzp9yKG4n
SFZMkosMHe9LiCEOsMuv187ClWCdmYkQalwq5++PA4drOcQ/KDgTZAD6EgU0Drma
S4ekQnfuZCXHc2Ryw1ek/hE51OI0Sy97Ww9S1JFtTnvZ4PV0Om2RdwEivDwbmC66
aA8LIZo6X66okEsRk+lUlneHDDgdQ92gEv1OhYf/2JRVPBHhy+6Qd66DLwd+HOW0
01csfFM7IZhAVuP0J5ZbQB1+k8bL2Q7IhW/XhbOJlypJVAWuoWaUNPTRCHb7Jp4K
YqAhR/yarpQxFKP+zTfV
=OIPS
-----END PGP SIGNATURE-----

--UK1lfQXsnwKrySH9--


--===============6693026817336966748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6693026817336966748==--
