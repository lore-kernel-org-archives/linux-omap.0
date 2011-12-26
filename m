From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 4/4] ASoC: OMAP: ams-delta: drop
	.set_bias_level callback
Date: Mon, 26 Dec 2011 21:43:23 +0100
Message-ID: <201112262143.23704.jkrzyszt@tis.icnet.pl>
References: <201112261330.22783.jkrzyszt@tis.icnet.pl>
	<20111226172349.GK8722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20111226172349.GK8722@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Monday 26 of December 2011 at 18:23:50, Mark Brown wrote:
> On Mon, Dec 26, 2011 at 01:30:22PM +0100, Janusz Krzysztofik wrote:
> 
> > > Why's this code not been dropped and what is it for?
> 
> > It is, and will be, used by another regulator consumer, the modem. The 
> > device is controlled by the generic serial8250 driver, extended with a 
> > custom .pm hook which enables/disables the regulator. The above code, 
> > temporarily shared with the ASoC device before updated, is now just 
> > moved down the board file where the modem related bits are located (see 
> > patch 3/4).
> 
> > Any hints like that for the codec driver?
> 
> The main thing that looks bad here is that you're keeping track of the
> state of the regulator by hand.  It may be that the upper layers aren't
> reference counting in which case you might need this but it certainly
> looks very suspicious as-is.

OK, I can try to examine how the serial8250 driver tracks the device 
power state when calling the .pm hook and if it looks safe to drop that 
regulator state manual tracking.

Thanks,
Janusz
