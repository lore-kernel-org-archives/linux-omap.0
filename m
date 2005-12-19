From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Mon, 19 Dec 2005 13:04:36 +0000
Message-ID: <20051219130436.GC11932@flint.arm.linux.org.uk>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
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

On Mon, Dec 19, 2005 at 09:52:59AM -0300, Anderson.Briglia@indt.org.br wrote:
> > > This patch improves the CONFIG_HOTPLUG support on the mmc core driver.
> > > Kernel version: 2.6.15-rc4-omap1
> > 
> > Please explain how this "improves" the support.
> 
> As we can see on usb core driver, there's a compiler directive that
> bypass the hotplug function if the CONFIG_HOTPLUG is not selected.
> I think I could add this "support" on the MMC driver. Just a
> optimization.

Just because some other subsystem does something does not make it
right for others to do the same.  I'd like you to explain:

1. what additional support this patch gives us.
2. what the nature of the optimisation is.

> Please, correct me if I'm wrong.

I don't know if you're wrong because I don't understand the reasoning
behind the change.
