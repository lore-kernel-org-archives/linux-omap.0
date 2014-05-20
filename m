From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 20 May 2014 07:12:03 +0200
Message-ID: <20140520051203.GB28812@earth.universe>
References: <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com> <5379CD24.6040508@ti.com>
 <20140519160447.GB4849@atomide.com> <537A55EB.1080507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7151178355493616650=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <537A55EB.1080507@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============7151178355493616650==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 10:05:15PM +0300, Tomi Valkeinen wrote:
> On 19/05/14 19:04, Tony Lindgren wrote:
>=20
> > In many cases however we do have multiple compatible strings that
> > describe how the device is wired. See drivers/tty/serial/of_serial.c
> > for example. It has "ns16550" but then it also has additional
> > "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".
>=20
> All those sound like SoC components. In that case it sounds fine to have
> the device compatible contain the SoC name. We're talking here about
> external, detachable devices.
>
> >>> Not use what you're after with the SPI example though, but sounds
> >>> like that's something different.
> >>
> >> I think Sebastien's example is just like the issue here.
> >=20
> > Hmm is there some existing example in the kernel like that?
>=20
> No, Sebastien's example was just a hypothetical case. Here, using your
> way of having SoC specific data in the .dts, we would have
> "sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
> sensor we'd have, say, "synaptics,xyz123-omap-spi".

Yes, that's what I wanted to say :)

My name is spelled Sebastian, though. Sebastien is the French
variant as far as i know.

-- Sebastian

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTeuQjAAoJENju1/PIO/qap20P/3tjZaQpb1x298p7smCvD4hk
pQbFDRSrvox2d8g7oXX2LoPTF4lD+hmiC2g2lzb4LFdWfCWbzKpZr8crLg5t1h5n
zQJGuMVep6AOAD3rYz9fKg9EyH1WxCmQdsFCe2TYsRHgZfgs4Z4DVCgzRPXTonbU
FjQyaTMrRqd3zKg68wvD7rvUTfLe85g6KpxCGOzNj5XPH8m1cKy9CxdujAm2+9hS
nbdpUn0NpuTMXh/Sdl3hqvc5qFsr/4263kveYlty7gN5r+ZzEk/tp0R6GHBBrXgF
zrzfpyF+4DjMK9rhx0skcQ3Uvep8ZRNYZ3opbwtktea2Kygb5QIsUjYu+6Yf+YcE
0FJcxU0GSz5p/TdKaH2WOLLkZHL53VrJRJglsZadwKMaKTopZ4w6fp3hP73jV/Ti
HsT7sPAvdBQY3qx1kTsDN/7TjARmk1phGGjjEQKEh6b1GaFz76YO46gFW+/CFs8X
8esP/CqEmAhPbsOiV46AvvI2L+GXeftnRN7SMw3zA225bHRUEwfnlah8KtaB5Ccm
pKg8ZGw/Q9f38mvYTh3AgnfWIje7R3WkmSsflpHUUea3oyOhtY1jRv79L2k7KNTQ
j9WJzeYl6gSRMABoyWSwsq/PvnWdxy3N82duHBTOl+50p3ffUBi3yPo+pRQ3q+90
UPsr6+JMftkI/gzMjmwx
=yUhx
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


--===============7151178355493616650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7151178355493616650==--
