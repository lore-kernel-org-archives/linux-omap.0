From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3 v3] ASoC: OMAP: Enhance OMAP1510 DMA
	progress	software counter
Date: Tue, 18 Aug 2009 14:45:41 +0100
Message-ID: <20090818134540.GB24620@sirena.org.uk>
References: <200908101050.08074.jkrzyszt@tis.icnet.pl>
	<200908110107.11485.jkrzyszt@tis.icnet.pl>
	<200908112144.30731.jkrzyszt@tis.icnet.pl>
	<20090817122605.0b240ea7.jhnikula@gmail.com>
	<20090817100313.GA5756@rakim.wolfsonmicro.main>
	<4A8AAFAD.9050705@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4A8AAFAD.9050705@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 18, 2009 at 03:42:05PM +0200, Janusz Krzysztofik wrote:

> And now, how is the patch 1/3 supposed to get into the mainline? Whom  
> should I ping from time to time to get it integrated? If not then, as  
> you know for sure, applying patch 2/3 whithout 1/3 will result in ASoC  
> support for OMAP1510 broken.

Normally the OMAP tree, though that's possibly a bit tricky due to the
ARM tree closing early.  If Tony's OK with merging via the ALSA tree we
could also apply the ARM patch there?
