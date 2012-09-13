From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/11] ASoC: OMAP: Convert to use dmaengine
Date: Thu, 13 Sep 2012 16:11:43 +0800
Message-ID: <20120913081141.GD20959@opensource.wolfsonmicro.com>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 02:46:56PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> This series will switch the OMAP audio to use dmaengine.
> The final patch which does the switch was based on Russell King's earlier patch.

I'm fine with this from the ASoC side but it sounds like you're going to
respin anyway.  Are the earlier bits of the series safe to apply without
the last bit, it seems like that's the only bit that really needs a
respin so we may as well go ahead and apply the earlier bits now?
