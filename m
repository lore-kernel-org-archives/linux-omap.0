From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Mon, 19 Dec 2005 17:44:41 +0200
Message-ID: <1135007081.12906.25.camel@two.research.nokia.com>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
	<F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
	<20051219130436.GC11932@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051219130436.GC11932@flint.arm.linux.org.uk>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2005-12-19 at 13:04 +0000, Russell King - ARM Linux wrote:

> > As we can see on usb core driver, there's a compiler directive that
> > bypass the hotplug function if the CONFIG_HOTPLUG is not selected.
> > I think I could add this "support" on the MMC driver. Just a
> > optimization.
> 
> Just because some other subsystem does something does not make it
> right for others to do the same.  I'd like you to explain:
> 
> 1. what additional support this patch gives us.
> 2. what the nature of the optimisation is.

With the patch the kernel text segment becomes a wee bit smaller if
certain criteria is met; that much should be obvious.

It's a trivial patch, true, but quite a valid one.  If the MMC hotplug
function is not to be called from anywhere, no reason to waste space in
compiling it in.

Cheers,
Juha
