From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 03/15] dmaengine: Add flags parameter to
 dmaengine_prep_dma_cyclic()
Date: Sat, 22 Sep 2012 11:09:58 -0400
Message-ID: <20120922150957.GH4495@opensource.wolfsonmicro.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 14, 2012 at 03:05:46PM +0300, Peter Ujfalusi wrote:
> With this parameter added to dmaengine_prep_dma_cyclic() the API will be in
> sync with other dmaengine_prep_*() functions.
> The dmaengine_prep_dma_cyclic() function primarily used by audio for cyclic
> transfer required by ALSA, we use the from audio to ask dma drivers to
> suppress interrupts (if DMA_PREP_INTERRUPT is cleared) when it is supported
> on the platform.

Are you sure this was generated against for-3.7?  There's fuzz against
dmaengine.h and git can't find the blobs to do resolution.  Anyway, I
applied this and the rest of the series.
