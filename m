From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay (latency)
	handling in	soc/omap
Date: Wed, 3 Mar 2010 13:38:07 +0000
Message-ID: <20100303133806.GA15105@sirena.org.uk>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 03, 2010 at 03:08:03PM +0200, Peter Ujfalusi wrote:

> Peter Ujfalusi (5):
>   ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
>   ASoC: core: soc level wrapper for pcm_pointer callback
>   ASoC: core: Add delay operation to snd_soc_dai_ops

I'll apply these just now, thanks!

>   OMAP3: McBSP: Add interface for FIFO caused delay query
>   ASoC: OMAP3: Report delay caused by the internal FIFO

These also look OK to me but there's the arch/arm dependency.
