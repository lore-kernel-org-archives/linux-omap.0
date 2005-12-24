From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Sat, 24 Dec 2005 22:35:02 +0000
Message-ID: <20051224223502.GA22630@flint.arm.linux.org.uk>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
	<20051219130436.GC11932@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B6813@mzebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <F26D8BDC5BC8014A909C6D45468F69EF022B6813@mzebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 19, 2005 at 01:02:36PM -0300, Anderson.Briglia@indt.org.br wrote:
> On Mon, Dec 19, 2005 at 09:52:59AM -0300, Anderson.Briglia@indt.org.br wrote:
> > I'd like you to explain:
> > 1. what additional support this patch gives us.
> 
> I'm working on MMC hotplug system. This patch is a inicial work to provide
> a minimal kernel configuration hotplug support (and prevent future bugs). 

Either you have hotplug support or you don't.  There is no half-way
house implemented in any kernel subsystem.

> It's necessary more interaction between the MMC core and the MMC block
> driver. When a MMC card is inserted/removed the MMC block driver should
> be informed and adds/removes the device information from the kernel.
> I'm trying to implement this interaction.

This is already implemented.  The MMC block driver will be called via
mmc_blk_probe() when a card is inserted, and via mmc_blk_remove()
when it is removed.

> > 2. what the nature of the optimisation is.
> 
> AFAIK, compiler directives are a guiding for what will/won't be compiled.
> IMHO, if the kernel hotplug support is not selected, doesn't make sense
> that the mmc_bus_hotplug function be compiled. When the MMC core and
> MMC block interaction will be implemented the mmc_bus_hotplug function
> should not be compiled providing that hotplug support.

Right.  You could eliminate the whole function and define mmc_bus_hotplug
to NULL when CONFIG_HOTPLUG is unset, which will eliminate even more
bytes.
