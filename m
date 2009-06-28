From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] [RFC] ASoC: OMAP: fix OMAP1510 broken PCM
 pointer callback
Date: Sun, 28 Jun 2009 22:37:32 +0300
Message-ID: <20090628223732.53954402.jhnikula@gmail.com>
References: <200906280021.05931.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200906280021.05931.jkrzyszt@tis.icnet.pl>
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
Cc: Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 28 Jun 2009 00:21:05 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> This patch tries to work around the problem of broken OMAP1510 PCM
> playback pointer calculation by replacing DMA function call that
> incorrectly tries to read the value form DMA hardware with a value
> computed locally from an already maintained variable
> omap_runtime_data.period_index.
> 
> Tested on OMAP5910 based Amstrad Delta (E3) using work in progress
> ASoC driver.
> 
> Based on linux-2.6-asoc.git v2.6.31-rc1.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> It seems that on OMAP1510, DMA Channel Progress Counter registers 
> (DMA_CPC_CH[0-8]) always contain values derived from DMA channels
> destination port address, even if constant, and there are no DMA
> registers available that would follow DMA channels source port
> address. Because of this limitation, current implementation of
> omap_get_dma_src_pos() for OMAP1510 is broken and doesn't seem to be
> easy correctable.
> 
Hi

Before going into workaround, did you try to change function
omap_get_dma_src_pos to read CSSA_L instead of CPC in
arch/arm/plat-omap/dma.c that I was speculating in mail below?

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-June/018569.html

While CPC seems to be correct [1], you mentioned before that patch below
broke the older ALSA driver so it's worth to find out if the problem
can be corrected by simple one line fix (or two if omap_get_dma_dst_pos
need to be fixed as well).

http://marc.info/?l=linux-omap&m=121280267705523


-- 
Jarkko

1. http://www.google.com/search?q=spru674
