From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] board-rx51-peripherals: split vaux3
 and vmmc2 supplies
Date: Thu, 15 Oct 2009 10:01:24 +0100
Message-ID: <20091015090124.GA29371@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
	<20091008132109.GD29176@rakim.wolfsonmicro.main>
	<20091009064529.GD6616@esdhcp037198.research.nokia.com>
	<20091009110346.GC5082@sirena.org.uk>
	<20091012080858.GB13234@esdhcp037198.research.nokia.com>
	<20091012091820.GC3308@rakim.wolfsonmicro.main>
	<20091014171548.GI12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091014171548.GI12700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 14, 2009 at 10:15:48AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [091012 02:18]:
> > On Mon, Oct 12, 2009 at 11:08:58AM +0300, Eduardo Valentin wrote:

> > > I'm afraid using dev_name is not that easy. The mmc driver generates device
> > > name at runtime. That's why this board file setups .dev at runtime as well.

...

> > > So, changing this supply to something static using .dev_name it is not
> > > possible with current code. That would need refactoring the whole mmc and
> > > hsmmc setup. And the device naming procedure is dependent on cpu as well.
> > > Check arch/arm/mach-omap2/device.c:omap2_init_mmc.

> > same answer each time it's run?  How does this work with the clock API?

> The clocks are matched using clkdev. Basically the driver just requests
> functional clock (fck) and interface clock (ick):

> $ grep mmci arch/arm/*omap*/clock*.c
> arch/arm/mach-omap1/clock.c:	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
> arch/arm/mach-omap1/clock.c:	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),

So this is using the standard dev_name based clkdev matching which
Eduardo said was impossible for the regulators.  Is it just that this
will actually work fine for the regulators or is there some other magic
in the OMAP code that joins things up?
