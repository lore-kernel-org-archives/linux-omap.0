From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/7] ASoC: omap: Deprecate omap-pcm for
 sdma-pcm
Date: Wed, 25 Apr 2018 13:10:44 +0300
Message-ID: <20180425101044.GA17531@bitmer.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180425061837.14145-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: aaro.koskinen@iki.fi, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 25, 2018 at 09:18:30AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> omap-pcm served us well over the years, but there is no reason to keep it around
> as we can rely on generic dmaengine_pcm code without the need to maintain custom
> code.
> 
> The series has been tested on:
> omap3 beagle-xm, omap4 PandaES, omap4 Blaze (SDP), am57xx beagle-x15, dra7 evm.

For sound/soc/omap/

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

> I was not able to test on OMAP1 or OMAP2 for various reasons, but mainly because
> neither Nokia 770 or Nokia n810 audio probes with linux-next. It does not matter
> if I have omap-pcm or sdma-pcm...
> 
> I would be grateful if someone can give tested-by or pointers on how to get
> 770/n810 audio working.
> 
What I noticed some time ago on N810 but not time to fix it that OMAP mux
change dropped muxing audio McBSP pins. Those pins are muxed by reset or
bootloader to another function.

Probably a few lines to arch/arm/boot/dts/omap2420-n810.dts etc.

-- 
Jarkko
