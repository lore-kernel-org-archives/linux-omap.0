From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
Date: Sun, 30 Aug 2015 11:44:45 -0500
Message-ID: <20150830164444.GA22471@deathstar>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
 <20150724163946.GN11162@sirena.org.uk>
 <55E31701.7050807@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E31701.7050807@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 30, 2015 at 05:45:21PM +0300, Jarkko Nikula wrote:
> Hi
> 
> On 07/24/2015 07:39 PM, Mark Brown wrote:
> > On Wed, Jul 22, 2015 at 08:46:09PM +0200, Sebastian Reichel wrote:
> >> Since commit ddcad7e9068eb omap2_mcspi_set_cs() is called without
> >> runtime power management requested. Thus the below kernel oops may be
> >> generated if a device is accessed after the runtime power management
> >> timeout. This patch fixes the problem by requesting runtime power
> >> management in omap2_mcspi_set_cs().
> >>
> >> [   13.933959] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09802c
> >> [   13.940490] pgd = cfb38000
> >> [   13.946594] [fa09802c] *pgd=48011452(bad)
> >> [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> >> [   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt omap_wdt
> >> [   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1+ #363
> >> [   13.971801] Hardware name: Nokia RX-51 board
> >> [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> >> [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
> >> [   13.991485] LR is at spi_set_cs+0x5c/0x60
> > 
> > Please don't paste entire backtraces into commit messages, they are very
> > large and almost entirely noise (for example in this case the entire
> > explanation is in the commit message itself).  If you feel a backtrace
> > helps clarify things then please present an *edited* highlight of the
> > relevant sections.
> > present
> > 
> Is there update to this patch? I don't see such in 4.2.0-rc8+. I hit
> this same issue on Nokia N900 WLAN (CONFIG_WL1251=m and
> CONFIG_WL1251_SPI=m) and googling lead to this patch which made the WLAN
> working.
> 
> If you are going to resend this, please feel free to add my tested by:
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

The patch is currently sitting in linux-next.

Not sure why it wasn't merged with 4.2.0-rc8.
