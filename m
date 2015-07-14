From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 14 Jul 2015 11:33:42 -0500
Message-ID: <20150714163342.GA8512@deathray>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714071412.GA12844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 14, 2015 at 09:14:12AM +0200, Pali Roh=E1r wrote:
> On Monday 13 July 2015 17:36:07 Michael Welling wrote:
> > On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=E1r wrote:
> > > I think nothing special. I just call:
> > >=20
> > > export ARCH=3Darm
> > > export CROSS_COMPILE=3Darm-linux-gnueabi-
> > > make rx51_defconfig
> > > rm -f arch/arm/boot/zImage
> > > make -j12 zImage modules omap3-n900.dtb CONFIG_DEBUG_SECTION_MISM=
ATCH=3Dy
> > > cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > arch/=
arm/boot/zImage.new
> > > mv arch/arm/boot/zImage.new arch/arm/boot/zImage
> > >
> >=20
> > Where are you getting rx51_defconfig from?
> >=20
> > This does not appear to be in the kernel source any longer.
> >=20
> > Can you try the above with omap2plus_defconfig?
> > =20
>=20
> It is in my linux-n900 repository: https://github.com/pali/linux-n900
> Repository contains more n900 specific patches but SPI code is unpatc=
hed
>=20
> https://github.com/pali/linux-n900/blob/HEAD/arch/arm/configs/rx51_de=
fconfig
>=20
> Later in week I can try to compile also with omap2plus_defconfig...
> But in my opinion kernel should not crash with different configuratio=
n.

True.

Could you try the following change to the set_cs function and see if it=
 helps.

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcsp=
i.c
index 5867384..666038b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -245,16 +245,18 @@ static void omap2_mcspi_set_enable(const struct s=
pi_device *spi, int enable)
=20
 static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
+	struct omap2_mcspi_cs *cs =3D spi->controller_state;
 	u32 l;
=20
-	/* The controller handles the inverted chip selects
-	 * using the OMAP2_MCSPI_CHCONF_EPOL bit so revert
-	 * the inversion from the core spi_set_cs function.
-	 */
-	if (spi->mode & SPI_CS_HIGH)
-		enable =3D !enable;
+	if (cs) {
+
+		/* The controller handles the inverted chip selects
+		 * using the OMAP2_MCSPI_CHCONF_EPOL bit so revert
+		 * the inversion from the core spi_set_cs function.
+		 */
+		if (spi->mode & SPI_CS_HIGH)
+			enable =3D !enable;
=20
-	if (spi->controller_state) {
 		l =3D mcspi_cached_chconf0(spi);
=20
 		if (enable)
