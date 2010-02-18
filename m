From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 11:01:06 +0000
Message-ID: <20100218110106.GC3542@rakim.wolfsonmicro.main>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266417960-22787-2-git-send-email-ilkka.koskinen@nokia.com>
	<20100218002543.GG21755@atomide.com>
	<alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilkka Koskinen <ikoskine@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 18, 2010 at 12:58:55PM +0200, Ilkka Koskinen wrote:

> Is that easiest way to do that? I mean, I'm afraid that the ALSA
> tree doesn't have Janusz Krzysztofik's McBSP register cache patches
> nor does it have your "omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3"
> patch either.

> Anyway, I'll send the updated patches still today.

Given that the merge window is likely to open within a week it might be
simplest to just wait until that's sorted through, or if the patches
will both apply in the OMAP tree and merge cleanly with ASoC then I'd be
happy with pushing them that way (I'd expect, I'd need to review the
second one).
