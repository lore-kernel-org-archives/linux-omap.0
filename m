From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add
	support	for DMA channel self linking on OMAP1510
Date: Mon, 24 Aug 2009 15:49:03 +0300
Message-ID: <20090824124902.GH7069@atomide.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231945.40187.jkrzyszt@tis.icnet.pl>
	<20090823180543.GA6167@opensource.wolfsonmicro.com>
	<200908232038.05593.jkrzyszt@tis.icnet.pl>
	<20090823184943.GA6994@opensource.wolfsonmicro.com>
	<20090824084920.c99c561a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090824084920.c99c561a.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [090824 08:47]:
> On Sun, 23 Aug 2009 19:49:43 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > On Sun, Aug 23, 2009 at 08:38:05PM +0200, Janusz Krzysztofik wrote:
> > > Sunday 23 August 2009 20:05:43 Mark Brown wrote:
> > 
> > > > then what are the other 
> > > > patches that depend on this? Nobody reported any issues in testing with 
> > > > the other OMAP patches.
> > 
> > > Dependency on patch 1/3 is not compile time, but run time, and OMAP1510 
> > > specific, that's probably why nobody has reported any issues.
> > 
> > OK, given that and the fact that you're reporting that none of these
> > files are afected by any of the other patches it sounds like it'd be
> > better to keep it in the OMAP tree unless Tony says otherwse.
> 
> Yep, Janusz's commits 64844a6ac8ddd586cb832fea7cf2e93e5e7e03f4 and
> 471e3dec3abe2d41e8c742046353fcb01bc2459e do not cause problems on other
> OMAPs but will cause that ASoC on 1510 is broken until his DMA
> patch(es) are applied. I'm sure you Janusz will ping Tony until he'll
> apply them :-)
> 
> We should remember that arch/arm/plat-omap/mcbsp.c changes done via
> ALSA tree has been an exception and that's only for simpler procedure.
> McBSP is not so critical if sources goes out-of-sync but DMA is.

Sorry for the delay in replying. I'm OK for these to go in via the alsa
tree as there are not currently other patches pending in the mcbsp or
dma area for omap. So I think it's better merge all the audio related
patches together in this case.

Acked-by: Tony Lindgren <tony@atomide.com>
