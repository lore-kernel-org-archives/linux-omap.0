From: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>
Subject: RE: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Mon, 26 Dec 2005 15:46:58 -0300
Message-ID: <F26D8BDC5BC8014A909C6D45468F69EF022B6817@mzebe101.NOE.Nokia.com>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
	<20051219130436.GC11932@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B6813@mzebe101.NOE.Nokia.com>
	<20051224223502.GA22630@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux@arm.linux.org.uk
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > > I'd like you to explain:
> > > 1. what additional support this patch gives us.
> >=20
> > I'm working on MMC hotplug system. This patch is a inicial work to =
provide
> > a minimal kernel configuration hotplug support (and prevent future =
bugs).=20

> Either you have hotplug support or you don't.  There is no half-way
> house implemented in any kernel subsystem.

Ok.

> > It's necessary more interaction between the MMC core and the MMC =
block
> > driver. When a MMC card is inserted/removed the MMC block driver =
should
> > be informed and adds/removes the device information from the kernel.
> > I'm trying to implement this interaction.

> This is already implemented.  The MMC block driver will be called via
> mmc_blk_probe() when a card is inserted, and via mmc_blk_remove()
> when it is removed.

Yes, it's right. But if the MMC block driver is compiled as a module, =
it's not loaded automatically by the MMC core driver. Another problem is =
a bug on mmc omap driver: if a card is released, the sysfs and /dev =
entries are not removed (I'm using udev).

> > > 2. what the nature of the optimisation is.
> >=20
> > AFAIK, compiler directives are a guiding for what will/won't be =
compiled.
> > IMHO, if the kernel hotplug support is not selected, doesn't make =
sense
> > that the mmc_bus_hotplug function be compiled. When the MMC core and
> > MMC block interaction will be implemented the mmc_bus_hotplug =
function
> > should not be compiled providing that hotplug support.

> Right.  You could eliminate the whole function and define =
mmc_bus_hotplug
> to NULL when CONFIG_HOTPLUG is unset, which will eliminate even more
> bytes.

Ok.

Anderson Briglia
