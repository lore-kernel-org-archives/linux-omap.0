From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3 v3] ASoC: OMAP: Enhance OMAP1510 DMA
 progress software counter
Date: Tue, 18 Aug 2009 19:57:01 +0300
Message-ID: <20090818195701.6f260d33.jhnikula@gmail.com>
References: <200908101050.08074.jkrzyszt@tis.icnet.pl>
	<200908110107.11485.jkrzyszt@tis.icnet.pl>
	<200908112144.30731.jkrzyszt@tis.icnet.pl>
	<20090817122605.0b240ea7.jhnikula@gmail.com>
	<20090817100313.GA5756@rakim.wolfsonmicro.main>
	<4A8AAFAD.9050705@tis.icnet.pl>
	<20090818134540.GB24620@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090818134540.GB24620@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 18 Aug 2009 14:45:41 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Tue, Aug 18, 2009 at 03:42:05PM +0200, Janusz Krzysztofik wrote:
> 
> > And now, how is the patch 1/3 supposed to get into the mainline? Whom  
> > should I ping from time to time to get it integrated? If not then, as  
> > you know for sure, applying patch 2/3 whithout 1/3 will result in ASoC  
> > support for OMAP1510 broken.
> 
> Normally the OMAP tree, though that's possibly a bit tricky due to the
> ARM tree closing early.  If Tony's OK with merging via the ALSA tree we
> could also apply the ARM patch there?

I would say that it's better to keep in Tony's hand since otherwise
there can be risk for DMA code being out-of-sync as there are quite
frequent other PM, OMAP4, errata, etc. patches coming into it.

Of course it means that OMAP1510 audio is broken until the patch 1/3 is
merged but probably patch can be merged as a fix if merge window is
missed.


-- 
Jarkko
