From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
 for DMA channel self linking on OMAP1510
Date: Mon, 24 Aug 2009 23:06:13 +0100
Message-ID: <20090824220612.GB4338@sirena.org.uk>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231945.40187.jkrzyszt@tis.icnet.pl>
	<20090823180543.GA6167@opensource.wolfsonmicro.com>
	<200908232038.05593.jkrzyszt@tis.icnet.pl>
	<20090823184943.GA6994@opensource.wolfsonmicro.com>
	<20090824084920.c99c561a.jhnikula@gmail.com>
	<20090824124902.GH7069@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090824124902.GH7069@atomide.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 24, 2009 at 03:49:03PM +0300, Tony Lindgren wrote:

> > We should remember that arch/arm/plat-omap/mcbsp.c changes done via
> > ALSA tree has been an exception and that's only for simpler procedure.
> > McBSP is not so critical if sources goes out-of-sync but DMA is.

> Sorry for the delay in replying. I'm OK for these to go in via the alsa
> tree as there are not currently other patches pending in the mcbsp or
> dma area for omap. So I think it's better merge all the audio related
> patches together in this case.

Applied, thanks.
