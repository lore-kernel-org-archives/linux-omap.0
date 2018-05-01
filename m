From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v3 7/7] ASoC: omap: Delete the obsolete
	omap-pcm
Date: Tue, 1 May 2018 22:02:47 +0300
Message-ID: <1419db3f-0ed1-6d82-8c3a-2310b60c8250@bitmer.com>
References: <20180430111958.31289-1-peter.ujfalusi@ti.com>
 <20180430111958.31289-8-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430111958.31289-8-peter.ujfalusi@ti.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On 04/30/18 14:19, Peter Ujfalusi wrote:
> All DAI drivers are now using the new sdma-pcm platform driver. The
> omap-pcm can be removed from the tree, but we need to keep the SND_OMAP_SOC
> Kconfig option until the relevant defconfigs are updated to avoid
> regression due to missing audio.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  include/sound/omap-pcm.h  |  30 -----
>  sound/soc/omap/Kconfig    |   3 +-
>  sound/soc/omap/Makefile   |   2 -
>  sound/soc/omap/omap-pcm.c | 262 --------------------------------------
>  4 files changed, 1 insertion(+), 296 deletions(-)
>  delete mode 100644 include/sound/omap-pcm.h
>  delete mode 100644 sound/soc/omap/omap-pcm.c
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
