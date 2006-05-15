From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] Add backlight support for Amstrad Delta
Date: Mon, 15 May 2006 02:38:14 -0700
Message-ID: <20060515093813.GG8368@atomide.com>
References: <20060402163614.GC26949@earth.li>
	<20060428102637.GH31797@atomide.com>
	<20060429160513.GT7570@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060429160513.GT7570@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Sorry for long delay replaying on this one too.

* Jonathan McDowell <noodles@earth.li> [060429 09:07]:
> On Fri, Apr 28, 2006 at 03:26:38AM -0700, tony@atomide.com wrote:
> > * Jonathan McDowell <noodles@earth.li> [060402 09:38]:
> > > This patch adds support for the Amstrad Delta LCD backlight. It's
> > > the first patch in a series of 3 enabling full LCD support for the
> > > Delta and is the least intrusive, allowing control of the backlight
> > > through the existing backlight class infrastructure.
> > Looks good. Can you please separate
> > arch/arm/mach-omap1/board-ams-delta.c changes and other core omap
> > changes into separate patch in this series?
>  
> Sure. So you'd want it as the following patches:
> 
> * Add the LCD support to drivers/video/omap/
> * Add the support to arch/arm/mach-omap1/board-ams-delta.c for the
>   above.
> * Add the backlight driver to drivers/video/backlight/
> * Add the support to arch/arm/mach-omap1/board-ams-delta.c for the
>   above.
> 
> ?
> 
> Or possibly only the one patch against
> arch/arm/mach-omap1/board-ams-delta.c pulling in both the LCD and
> backlight support? Or should I submit the backlight support to mainline
> given it doesn't touch OMAP specific code?

Yes, please send backlight patches to mainline directly. Then one patch
for drivers/video/omap, one for board-ams-delta, and one for your
defconfig.
 
> Also are you planning to add Mark Underwood's 444 patch, as having that
> there before I rebase my patches would be very useful.

Sorry, do you have a URL for that? Or maybe it's been already applied?

Regards,

Tony
