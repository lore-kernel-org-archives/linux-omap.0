From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 1/3] Add backlight support for Amstrad Delta
Date: Sat, 29 Apr 2006 17:05:13 +0100
Message-ID: <20060429160513.GT7570@earth.li>
References: <20060402163614.GC26949@earth.li>
	<20060428102637.GH31797@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060428102637.GH31797@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 28, 2006 at 03:26:38AM -0700, tony@atomide.com wrote:
> * Jonathan McDowell <noodles@earth.li> [060402 09:38]:
> > This patch adds support for the Amstrad Delta LCD backlight. It's
> > the first patch in a series of 3 enabling full LCD support for the
> > Delta and is the least intrusive, allowing control of the backlight
> > through the existing backlight class infrastructure.
> Looks good. Can you please separate
> arch/arm/mach-omap1/board-ams-delta.c changes and other core omap
> changes into separate patch in this series?
 
Sure. So you'd want it as the following patches:

* Add the LCD support to drivers/video/omap/
* Add the support to arch/arm/mach-omap1/board-ams-delta.c for the
  above.
* Add the backlight driver to drivers/video/backlight/
* Add the support to arch/arm/mach-omap1/board-ams-delta.c for the
  above.

?

Or possibly only the one patch against
arch/arm/mach-omap1/board-ams-delta.c pulling in both the LCD and
backlight support? Or should I submit the backlight support to mainline
given it doesn't touch OMAP specific code?

Also are you planning to add Mark Underwood's 444 patch, as having that
there before I rebase my patches would be very useful.

J.

-- 
/-\                             |   noodles is completely different
|@/  Debian GNU/Linux Developer |     between japan and the west
\-                              |
