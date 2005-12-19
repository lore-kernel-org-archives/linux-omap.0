From: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>
Subject: RE: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Mon, 19 Dec 2005 13:02:36 -0300
Message-ID: <F26D8BDC5BC8014A909C6D45468F69EF022B6813@mzebe101.NOE.Nokia.com>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
	<20051219130436.GC11932@flint.arm.linux.org.uk>
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

On Mon, Dec 19, 2005 at 09:52:59AM -0300, Anderson.Briglia@indt.org.br =
wrote:
> > > > This patch improves the CONFIG_HOTPLUG support on the mmc core =
driver.
> > > > Kernel version: 2.6.15-rc4-omap1
> > >=20
> > > Please explain how this "improves" the support.
> >=20
> > As we can see on usb core driver, there's a compiler directive that
> > bypass the hotplug function if the CONFIG_HOTPLUG is not selected.
> > I think I could add this "support" on the MMC driver. Just a
> > optimization.

> Just because some other subsystem does something does not make it
> right for others to do the same.

IMHO, the USB hotplug system is working well for usb block devices.

> I'd like you to explain:

> 1. what additional support this patch gives us.

I'm working on MMC hotplug system. This patch is a inicial work to =
provide a minimal kernel configuration hotplug support (and prevent =
future bugs).=20
It's necessary more interaction between the MMC core and the MMC block =
driver. When a MMC card is inserted/removed the MMC block driver should =
be informed and adds/removes the device information from the kernel. I'm =
trying to implement this interaction.

> 2. what the nature of the optimisation is.

AFAIK, compiler directives are a guiding for what will/won't be =
compiled. IMHO, if the kernel hotplug support is not selected, doesn't =
make sense that the mmc_bus_hotplug function be compiled. When the MMC =
core and MMC block interaction will be implemented the mmc_bus_hotplug =
function should not be compiled providing that hotplug support.

> > Please, correct me if I'm wrong.

> I don't know if you're wrong because I don't understand the reasoning
> behind the change.

Sorry if I didn't explain before. If I'm wrong, let me know.

BR,

Anderson Briglia
