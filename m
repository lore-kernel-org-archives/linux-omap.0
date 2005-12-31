From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Sat, 31 Dec 2005 16:00:38 +0000
Message-ID: <20051231160038.GA7934@flint.arm.linux.org.uk>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
	<20051219130436.GC11932@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B6813@mzebe101.NOE.Nokia.com>
	<20051224223502.GA22630@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B6817@mzebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <F26D8BDC5BC8014A909C6D45468F69EF022B6817@mzebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 26, 2005 at 03:46:58PM -0300, Anderson.Briglia@indt.org.br wrote:
> > This is already implemented.  The MMC block driver will be called via
> > mmc_blk_probe() when a card is inserted, and via mmc_blk_remove()
> > when it is removed.
> 
> Yes, it's right. But if the MMC block driver is compiled as a module,
> it's not loaded automatically by the MMC core driver.

That's not a kernel problem - the userspace tools (module-utils) do not
know how to interpret the MMC hotplug information to determine which
modules need loading.

However, it's quite likely that even if they did, we'll need to change
the way that the MMC drivers are bound to the MMC devices - it's possible
that a MMC device could be driven by more than one driver.

> Another problem is a bug on mmc omap driver: if a card is released,
> the sysfs and /dev entries are not removed (I'm using udev).

Which sysfs entries?  Could be that the omap driver doesn't detect
card removals correctly - or is asking the MMC subsystem to re-detect
cards before the card has actually disconnected from the bus.
