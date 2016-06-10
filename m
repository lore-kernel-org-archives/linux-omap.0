From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 11:32:12 +0300
Message-ID: <575A7B0C.40103@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com> <575A748A.4060009@ti.com>
 <87k2hx78yv.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hcc8xoQ32qgWRuPEMxstn3oP1HnmdGndU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k2hx78yv.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--hcc8xoQ32qgWRuPEMxstn3oP1HnmdGndU
Content-Type: multipart/mixed; boundary="d6wWnnlNOxxd1uhP0BRv7dKhCa7ccTojO"
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com,
 sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com,
 jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com,
 b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <575A7B0C.40103@ti.com>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com> <575A748A.4060009@ti.com>
 <87k2hx78yv.fsf@linux.intel.com>
In-Reply-To: <87k2hx78yv.fsf@linux.intel.com>

--d6wWnnlNOxxd1uhP0BRv7dKhCa7ccTojO
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/06/16 11:18, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Roger Quadros <rogerq@ti.com> writes:
>>> 	dwc->xhci_resource[1] =3D *res;
>>
>> Probably not as we don't want to change parent/child members.
>=20
> oh, you had already replied. Sorry. This is correct
>=20
np :).

So what i'll do is get the irq via platform_get_irq() and friends
and if it was a success use platform_get_resource() and friends
to get struct resource and just edit the relevant parts for the
XHCI irq resource.

Sounds OK?

something like this.

+	int			ret, irq;
+	struct resource		*res;
+	struct platform_device	*dwc3_pdev =3D to_platform_device(dwc->dev);
+
+	irq =3D platform_get_irq_byname(dwc3_pdev, "host");
+	if (irq =3D=3D -EPROBE_DEFER)
+		return irq;
+
+	if (irq <=3D 0) {
+		irq =3D platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq =3D=3D -EPROBE_DEFER)
+			return irq;
+
+		if (irq <=3D 0) {
+			irq =3D platform_get_irq(dwc3_pdev, 0);
+			if (irq <=3D 0) {
+				if (irq !=3D -EPROBE_DEFER) {
+					dev_err(dwc->dev,
+						"missing host IRQ\n");
+				}
+				return irq;
+			} else {
+				res =3D platform_get_resource(dwc3_pdev,
+							    IORESOURCE_IRQ, 0);
+			}
+		} else {
+			res =3D platform_get_resource_byname(dwc3_pdev,
+							   IORESOURCE_IRQ,
+							   "dwc_usb3");
+		}
+
+	} else {
+		res =3D platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
+						   "host");
+	}
+
+	dwc->xhci_resources[1].start =3D irq;
+	dwc->xhci_resources[1].end =3D irq;
+	dwc->xhci_resources[1].flags =3D res->flags;
+	dwc->xhci_resources[1].name =3D res->name;
=20


--
cheers,
-roger


--d6wWnnlNOxxd1uhP0BRv7dKhCa7ccTojO--

--hcc8xoQ32qgWRuPEMxstn3oP1HnmdGndU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWnsQAAoJENJaa9O+djCTkE0P/jvx2ykvW7kbZbS5lij8LTyV
Bzsb8nnikLl/ljYTiEndveu752Szf9snTk1i7VBaZycEfSnEeP6RQx7ovDb3YviL
qvHzovgtlRXSU+e5s42DAyq/9e3OJEkqw63zRn3ILTsl3FhfmI+bEY7Y/3PemIcM
xANdsXwUYfTKw5tFq6GXIQvdgC5zbLXFHBQJrB9ZqGde2S4ZkAmLokSxF3KOfLrE
1DfOYZdryi9Jr0BM3vjqskCfeEHr/1C1gdtmtH1dRrmyB0XQNHJjFAiLLzCMjfKH
Z8IHJfBXb2r4mbHop6daXitym+g2giHkqq8EP9UEPSnq6R5F+W3FVzML3FHgTG92
GoNA6HcSg6YAY4NA+CM2fGRI6DfIdB1g90YwYA4GdgUdDDIIk2eLqYS1F+u9oDY/
bBJpuTeTtcF4ton2mxbrbMxrWBzYxhdWFtZv/BPIE92msazeH7y8eMpQbluWuJ0a
K1rsjd8FkpBe1lR7B1oco1Z073brcu2N1ud7rXOQ1P0pWNNNUjoSv7ds4JeVBWcG
PIrmigF123YC05B9bpfn79XzAcr7TVRpl6pJhmfTTAPOTS3YhQZ+WBMt3jefAoUh
2/7YWjAFOKoekcXeGewwdGV2aNkplaHf3f0y9wIROJWzXnO4zHSCgzTnFuvMaf9T
QZkjOntaTvLOVC4Vzd1A
=sQr6
-----END PGP SIGNATURE-----

--hcc8xoQ32qgWRuPEMxstn3oP1HnmdGndU--
