From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 00/20] OMAP ASoC changes in DMA
	utilization
Date: Thu, 20 Aug 2009 17:30:18 +0300
Message-ID: <20090820143017.GH12309@atomide.com>
References: <1250774523-7950-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1250774523-7950-1-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <eduardo.valentin@nokia.com> [090820 16:36]:
> Hello guys,
> 
> I've updated this series after some previous confusion from my side.
> 
> Now that all dependencies are merged (Janusz's patches and Jarkko's patch),
> I've based this series on Takashi's tree (master branch).
> 
> I've also talked with Tony and he agrees to have this changes merged
> by alsa tree. And as pointed by Jarkko, the mcbsp code is currently
> used only by Audio inside OMAP code. So, that should be safe.

You might want to merge patches 5 and 6 together as 5 adds the
fifo, then 6 limits it's size. But in general, for patches
1 - 14: Acked-by: Tony Lindgren <tony@atomide.com>
 
> It is the same series. It now includes patch description for
> every patch. And also, as I already said, it is based on master
> branch of sound-2.6.
> 
> Tested with beagle and rx51. Compiled tested for n770.
> 
> BR,
> 
> Eduardo Valentin (11):
>   OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1
>     registers.
>   OMAP: McBSP: Use appropriate value for startup delay
>   OMAP: McBSP: Add transmit/receive threshold handler
>   OMAP: McBSP: Create and export max_(r|t)x_thres property
>   OMAP: McBSP: Rename thres sysfs symbols
>   OMAP: McBSP: Change wakeup signals
>   OMAP: McBSP: Configure NO IDLE mode for DMA mode different of
>     threshold
>   ASoC: OMAP: Enable DMA burst mode
>   ASoC: OMAP: Make DMA 64 aligned
>   ASoC: OMAP: Use McBSP threshold to playback and capture
>   ASoC: OMAP: Use DMA operating mode of McBSP
> 
> Eero Nurkkala (7):
>   OMAP: McBSP: Provide functions for ASoC frame syncronization
>   OMAP: McBSP: Wakeups utilized
>   OMAP: McBSP: Retain McBSP FCLK clockactivity
>   OMAP: McBSP: Do not enable wakeups for no-idle mode
>   OMAP: McBSP: Let element DMA mode hit retention also
>   ASoC: Add runtime check for RFIG and XFIG
>   ASoC: Always syncronize audio transfers on frames
> 
> Peter Ujfalusi (2):
>   OMAP3: McBSP: Lower the maximum buffersize for McBSP1,3,4,5
>   OMAP: McBSP: Add link DMA mode selection
> 
>  arch/arm/mach-omap2/mcbsp.c             |    5 +
>  arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++++
>  arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++++++++++++++++++++-
>  sound/soc/omap/omap-mcbsp.c             |   77 ++++++-
>  sound/soc/omap/omap-pcm.c               |   14 +-
>  sound/soc/omap/omap-pcm.h               |    2 +
>  6 files changed, 511 insertions(+), 13 deletions(-)
> 
