From: <Mikko.Soikkala@Tietoenator.com>
Subject: RE: configuration problem with innovator 1510 & tsc2101
Date: Fri, 20 Jan 2006 10:04:30 +0200
Message-ID: <890E52023811004CB455C1B7C433BA101A8B31@dino.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: s-kipisz2@ti.com, dirk.behme@de.bosch.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Kipisz, Steven [mailto:s-kipisz2@ti.com]
>=20
> The Innovator 1510 uses an ADS7846 touch screen controller so it does
> not use the tsc2101.

So, the actual problem is in ./drivers/input/touchscreen/Kconfig.
TOUCHSCREEN_OMAP shouldn't select the TSC2101 when CONFIG_ARCH_OMAP15XX
is set. Can we use=20

        select OMAP_TSC2101 if ( MACH_OMAP_H2 || MACH_OMAP_H3 )

As it is done in ./sound/oss/Kconfig or should this include some other
platforms?

Thanks,
Mikko
