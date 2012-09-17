From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 00/15] ASoC: OMAP: Convert to use
 dmaengine
Date: Mon, 17 Sep 2012 15:21:41 +0530
Message-ID: <1347875501.1943.142.camel@vkoul-udesk3>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347851866.1943.126.camel@vkoul-udesk3>  <5056E300.809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5056E300.809@ti.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2012-09-17 at 11:44 +0300, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 09/17/2012 06:17 AM, Vinod Koul wrote:
> > On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> >> Hello,
> > 
> > dmaengine parts look good to me. How do you want to get this merged,
> > dmaengine or ASoC tree?
> 
> Thank you, I would prefer it to go via ASoC if it is not a problem. It is
> possible to separate the dmaengine core related patches and the patches for
> the OMAP drivers but I think it is better to keep them together so we can have
> them in a same tree for testing it further.
Sure I think this is better way to do.

-- 
~Vinod
