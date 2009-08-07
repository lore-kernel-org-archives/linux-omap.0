From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH][2.6.31-rc5] ARM: OMAP: McBSP: Fix ASoC on
	OMAP1510 by fixing API of omap_mcbsp_start/stop
Date: Fri, 7 Aug 2009 11:52:47 +0300
Message-ID: <200908071152.47243.peter.ujfalusi@nokia.com>
References: <1249628387-7372-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249628387-7372-1-git-send-email-jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 07 August 2009 09:59:47 ext Jarkko Nikula wrote:
> Simultaneous audio playback and capture on OMAP1510 can cause that second
> stream is stalled if there is enough delay between startup of the audio
> streams.
>
> Current implementation of the omap_mcbsp_start is starting both transmitter
> and receiver at the same time and it is called only for firstly started
> audio stream from the OMAP McBSP based ASoC DAI driver.
>
> Since DMA request lines on OMAP1510 are edge sensitive, the DMA request is
> missed if there is no DMA transfer set up at that time when the first word
> after McBSP startup is transmitted. The problem hasn't noted before since
> later OMAPs are using level sensitive DMA request lines.
>
> Fix the problem by changing API of omap_mcbsp_start and omap_mcbsp_stop by
> allowing to start and stop individually McBSP transmitter and receiver
> logics. Then call those functions individually for both audio playback
> and capture streams. This ensures that DMA transfer is setup before
> transmitter or receiver is started.
>
> Thanks to Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> for detailed problem
> analysis and Peter Ujfalusi <peter.ujfalusi@nokia.com> for info about DMA
> request line behavior differences between the OMAP generations.
>
> Reported-and-tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
>  arch/arm/plat-omap/mcbsp.c              |   50
> +++++++++++++++++++----------- sound/soc/omap/omap-mcbsp.c             |  
> 10 +++---
>  3 files changed, 39 insertions(+), 25 deletions(-)

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
