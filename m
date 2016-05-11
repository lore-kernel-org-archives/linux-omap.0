From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Wed, 11 May 2016 15:39:57 +0300
Message-ID: <87r3d8g44i.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-2-git-send-email-rogerq@ti.com> <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com> <87y47igr1g.fsf@linux.intel.com> <5732EA85.6050601@ti.com> <87y47hexja.fsf@linux.intel.com> <57331B85.2000003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57331B85.2000003@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>> static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
>>>> {
>>>>         struct dwc3_omap *omap =3D _omap;
>>>>         u32 reg;
>>>>
>>>>         spin_lock(&omap->lock);
>>>
>>> Do we really need a spin_lock for the dwc3-omap driver?
>>> Currently we won't be doing anything other than just
>>> clearing the irqstatus and re-enabling the interrupts.
>>=20
>> well, if there's no possibility of races, then no. But only testing will
>> say for sure, I guess. I didn't really go through the entire thing just
>> to a write a quick little template :-p
>>=20
> OK. Another hurdle I have is that how do I mask/unmask the interrupts?
> I do not see any masking bits, only enable/disable bits.
>
> I don't think we can use the enable/disable bits to mask as we'd loose
> events while the event is disabled.

I'm pretty sure your TRM discusses the usage of IRQSTATUS_RAW*
registers, doesn't it ? :-)

Those registers should be modified by HW even when interrupts are
disabled/masked. Note that, the IRQSTATUS_SET* and IRQSTATUS_CLR*
registers act more like mask/unmask than enable/disable considering we
can still read IRQ status using *RAW* registers.

See if below works fine for OMAP5, AM4 and AM5 SoCs:

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index af264493bbae..ece2f25ad2c3 100644
=2D-- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -165,20 +165,20 @@ static void dwc3_omap_write_utmi_ctrl(struct dwc3_oma=
p *omap, u32 value)
=20
 static u32 dwc3_omap_read_irq0_status(struct dwc3_omap *omap)
 {
=2D	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_0 -
+	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_0 -
 						omap->irq0_offset);
 }
=20
 static void dwc3_omap_write_irq0_status(struct dwc3_omap *omap, u32 value)
 {
=2D	dwc3_omap_writel(omap->base, USBOTGSS_IRQSTATUS_0 -
+	dwc3_omap_writel(omap->base, USBOTGSS_IRQSTATUS_RAW_0 -
 						omap->irq0_offset, value);
=20
 }
=20
 static u32 dwc3_omap_read_irqmisc_status(struct dwc3_omap *omap)
 {
=2D	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_MISC +
+	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_MISC +
 						omap->irqmisc_offset);
 }
=20
=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMygdAAoJEIaOsuA1yqREzgIQAIYNeWBlgNYOKmTquI3s8Qw5
jv9Z5RnY2eOMm1AOAVcLv97CPC8itEErnqllXFO0JT/4aUwfHKDHnp3jutasCyWj
wM5fTtoRpcAefiaWGMwbuJw/WutP+N9AsAeXHxWY3B6yRwwzwvwOgj0oR96h7AMu
sdRuBttvsawqdhB9KP7cbTwH9ohh+59SkJZ3bz+huQrdWJDsXzj6yNikdY4S2/J9
dNGrCe6UAf6UH2YB285bqjrGBaB6RJmDHFE7fX302Uzm95CjNSJly7njAxNFDZ4w
6ujAAwNQCpMjBd9ObYMXRSmxII64FzwUcpGpVRd4vHi3QvGVZFgOP2bhmgvu3EF7
mDUxbqt3xC3q/YvtBsDkRhY/dFjsv4o5eDRB7LagCVsbbWtHzcG4gIU4ixXGsN9d
8AZMKjlrH11Zn2Cu4DEwX4ziwIct1dOpPump+Nhj47b1mkG6hYlrHJmXZhpo7PbC
XhsvL2lfsxm7KaZIgsJCo1bXLSSk12rj8xPzhvbiIEqlUa6Nw9/kayxjOUre/zr/
Gn+s+lS07//6YasGrMi2AvFDHWkiSjuMcXdxzHdSWiIUTLNuO9yfSukZbHFEYYWo
0BFS4tKSolZE3cWnAVvDx/694ya0v+D1e3npjF/ml+Ya0zyQXWiIum6DdxK2P20y
1GPM8BuGjA4xQBF29KSW
=N4E6
-----END PGP SIGNATURE-----
--=-=-=--
