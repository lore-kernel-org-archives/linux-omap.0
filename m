From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] DMA: OMAP: fix OMAP1510 incorrect
	residue_granularity
Date: Sat, 02 Jun 2018 16:37:22 +0200
Message-ID: <5702664.ZErQ22uL87@z50>
References: <20180602142204.17460-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180602142204.17460-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Saturday, June 2, 2018 4:22:04 PM CEST Janusz Krzysztofik wrote:
> - by passing dma_caps.residue_granularity =
>   DMA_RESIDUE_GRANULARITY_DESCRIPTOR from drivers/dma/omap-dma.c.
> 
> Let's do the latter.
> 
> Created and tested against next-20180531 tag from linux-next tree.

I'm sorry, I missed 'git bisect reset' before testing the patch, it seems 
drivers/dma/omap-dma.c disappeared from next-20180531. I'll rework it and send 
again.

Thanks,
Janusz
