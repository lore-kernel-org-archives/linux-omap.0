From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v3 00/15] ASoC: OMAP: Convert to use
	dmaengine
Date: Mon, 24 Sep 2012 18:36:01 -0500
Message-ID: <5060EE61.1000902@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Hi Peter, Mark,

On 09/14/2012 07:05 AM, Peter Ujfalusi wrote:
> Hello,
>
> Changes since v2:
> - As it has been discussed the no_wakeup parameter has been replaced with flags
>    for the dmaengine APIs
>
> Changes since v1:
> - Support for pause/resume for OMAP audio via dmaengine
> - dmaengine: support for NO_PERIOD_WAKEUP in cyclic mode
>   - OMAP to keep supporting NO_PERIOD_WAKEUP for audio
>   - Other plaforms can also try to enable this mode since we have now generic
>     interface to do so.
>
> This series will switch the OMAP audio to use dmaengine.
> The final patch which does the switch was based on Russell King's earlier patch.
>
> The first 10 patch is to prepare the OMAP audio drivers for a smooth change to
> dmaengine:
> - sDMA FRAME sync mode is removed and replaced with PACKET mode
> - dai drivers no longer need to configure sDMA sync mode
> - dai drivers does not need to specify the DMA word length - with the exception
>    of the omap-hdmi driver which requires 32bit word length regardless of the
>    audio format in use
> - the McPDM driver used (to my surprise) hackish way of getting the DMA channel
>    and address - via defines from some header files
>
> After the conversion OMAP audio support should have the same features as before,
> no regressions expected.
>
> I have tested the series on:
> - BeagleBoard (audio via McBSP):
>   - aplay/arecord. In element mode and in threshold mode with different period
>     sizes
>   - mplayer -ao alsa: for direct ALSA access
>   - mplayer -ao pulse: via PulseAudio to test NO_PERIOD_WAKEUP feature
> - OMAP4 Blaze (audio via McPDM and DMIC)
>   - aplay/arecord
>   - mplayer -ao alsa: for direct ALSA access
>   - mplayer -ao pulse: via PulseAudio to test NO_PERIOD_WAKEUP feature
>
> The patches has been generated against:
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.7
>
> Janusz: Can you retest this series on OMAP1 to be sure I have not broken it?
> Ricardo: Can you test the omap-hmdi if it is still working?

I tested these changes from Mark's for-3.7 branch. HDMI audio is working 
fine after applying patch 03. Such patch is missing in Mark's branch and 
this causes a build break with omap2plus_defconfig. Not sure if this is 
expected, Most likely not.

Tested-by: Ricardo Neri <ricardo.neri@ti.com>

Ricardo
