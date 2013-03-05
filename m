From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: dwc3-omap: return -EPROBE_DEFER if probe
 has not yet executed
Date: Tue, 5 Mar 2013 17:21:56 +0200
Message-ID: <20130305152156.GK12123@arwen.pp.htv.fi>
References: <1362493320-13913-1-git-send-email-kishon@ti.com>
 <1362493320-13913-3-git-send-email-kishon@ti.com>
 <20130305145645.GG12123@arwen.pp.htv.fi> <513608E6.3010502@ti.com>
 <20130305150608.GI12123@arwen.pp.htv.fi> <51360CC0.9080108@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9170925911298898759=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51360CC0.9080108-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============9170925911298898759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline

--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2013 at 08:48:24PM +0530, kishon wrote:
> Hi,
>=20
> On Tuesday 05 March 2013 08:36 PM, Felipe Balbi wrote:
> >On Tue, Mar 05, 2013 at 08:31:58PM +0530, kishon wrote:
> >>Hi,
> >>
> >>On Tuesday 05 March 2013 08:26 PM, Felipe Balbi wrote:
> >>>On Tue, Mar 05, 2013 at 07:51:58PM +0530, Kishon Vijay Abraham I wrote:
> >>>>return -EPROBE_DEFER from dwc3_omap_mailbox in dwc3-omap.c, if the pr=
obe of
> >>>>dwc3-omap has not yet been executed or failed.
> >>>>
> >>>>Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >>>>---
> >>>>  drivers/usb/dwc3/dwc3-omap.c  |    7 +++++--
> >>>>  include/linux/usb/dwc3-omap.h |    6 +++---
> >>>>  2 files changed, 8 insertions(+), 5 deletions(-)
> >>>>
> >>>>diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-oma=
p.c
> >>>>index 19c6e72..9428f4e 100644
> >>>>--- a/drivers/usb/dwc3/dwc3-omap.c
> >>>>+++ b/drivers/usb/dwc3/dwc3-omap.c
> >>>>@@ -138,11 +138,14 @@ static inline void dwc3_omap_writel(void __iome=
m *base, u32 offset, u32 value)
> >>>>  	writel(value, base + offset);
> >>>>  }
> >>>>
> >>>>-void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
> >>>>+int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
> >>>>  {
> >>>>  	u32			val;
> >>>>  	struct dwc3_omap	*omap =3D _omap;
> >>>>
> >>>>+	if (!omap)
> >>>>+		return -EPROBE_DEFER;
> >>>>+
> >>>>  	switch (status) {
> >>>>  	case OMAP_DWC3_ID_GROUND:
> >>>>  		dev_dbg(omap->dev, "ID GND\n");
> >>>>@@ -185,7 +188,7 @@ void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_sta=
tus status)
> >>>>  		dev_dbg(omap->dev, "ID float\n");
> >>>>  	}
> >>>>
> >>>>-	return;
> >>>>+	return IRQ_HANDLED;
> >>>
> >>>IRQ_HANDLED ????
> >>
> >>Actually I did it that way since palmas_vbus_wakeup_irq can directly
> >>return the return value from dwc3_omap_mailbox. If this seems hacky
> >>to you, I'll change it.
> >
> >it does seem hacky :-) Try something like:
> >
> >ret =3D dwc3_omap_mailbox();
> >if (ret)
> >	print_error();
> >
> >return IRQ_HANDLED;
>=20
> hmm.. But there is one case where palmas_vbus_wakeup_irq should
> return EPROBE_DEFER. In the cold plug case, if palmas gets loaded
> before dwc3-omap, omap in dwc3_omap_mailbox will be NULL. So ideally
> palmas should be probed after dwc3-omap for this case. Returning
> IRQ_HANDLED or IRQ_NONE wont help here.

you can return IRQ_HANDLED but don't clear the IRQ status bits, which
will make the IRQ retrigger, right ?

If you return -EPROBE_DEFER from within the IRQ handler, what will
happen ? IRQ subsystem only understands IRQ_NONE, IRQ_WAKE_THREAD, and
IRQ_HANDLED. How do you suppose it will treat -EPROBE_DEFER ?

--=20
balbi

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNg2UAAoJEIaOsuA1yqREyZgP/ib4iFdUWrX8l/CvClRD/WRX
+U5mcGk+l6YI6zcZOoI6cjk0RFU9DiyDtuBdk62Koo5EinMY+e6ee3c9/1cuVBe3
Reya75hgchB7TKbr3/Vc0RtBaa6/RM1vNKWRFnGBeAVZl+JvUu/9d1u1XqvO5NPl
chSCYWFY6D7HDWr0epUO1n1NK5Y9V2/MfRHUEefmZkrDfKUIZ52kU3tyKgGTYyX8
ElAO9Kai46Yq3jyIUJL4NRZ9qsQtIkoDbOcsMArWcVSlWeu83BSxnB6lJcdcqYH6
6t+eTyJnDNx+19KfNvfu5x4fSh+DB5BaP9Txqt8YjpzTiU9L4jRqyxxeJvyJQOuC
XjSrpTh30szs49G4WWWKic9eQjllISyO7wy2zcsHuCgT+40+mfZra4Cf4XxHf+Lf
YqnHzQRB+d8/KIwRNo7o6uV6i4xQr1F/Ui4/e5AXunbpu6h130DHBlu1ijN7D50X
peQboN6R648qdQhdvE8Be7wUBtHfhpVwJufPi+206kJE9ympa63UYahf9LsJv2iu
Xt7whaayneo2xQHA1bQ7UJjy8b62OVL3y3MFbEoGk6L9RKeqjfNPrlAlFtRlpSH5
IHlCy9oClWHBkIhubIBmPzP+xFBU/TQB4a+EkR9OOwEXZSlp1zvFvup8U/ir7zuy
KsipPcN7RhoM0o3ybwkv
=5EF6
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--

--===============9170925911298898759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============9170925911298898759==--
