From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode
	updates for ASoC
Date: Wed, 19 May 2010 13:42:10 +0300
Message-ID: <20100519104209.GI4265@besouro.research.nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 10:13:10PM +0200, Liam Girdwood wrote:
> This series expands the OMAP mcbsp driver to support changing it's DMA operating
> mode and smart idle mode from client drivers. It's primarily aimed at lowering
> the power consumption for OMAP ASoC drivers by providing methods to gate clocks
> on the mcbsp interface at runtime.
> 
> I've also added a patch to remove the mcbsp DMA op mode sysfs set functionality.
> I think DMA op mode is very specific to the mcbsp client driver _only_ and
> shouldn't really be changed by userspace. Please let me know if you use this
> feature and I'll drop this patch.

Yeah, I'm not sure if that would be strong enough argument though. Unfortunately,
this dma op mode also couples with the usage of mcbsp internal buffer. Which in the very
end will mean a compromise between delay vs. pm, as you are probably aware.

So, letting userspace to toggle this mode will also mean they can choose between pm friendly
(op mode with frame and so on) or short delay friendly (element mode).

Of course, this might not be the best way of choosing it though.

> 
> Tony, can I get your ack to upstream via ALSA if it's ok
> 
> Thanks
> 
> Liam
> 
>  arch/arm/plat-omap/include/plat/mcbsp.h |   17 +++
>  arch/arm/plat-omap/mcbsp.c              |  183 ++++++++++++++++++++++++++-----
>  sound/soc/omap/omap-mcbsp.c             |   22 ++++-
>  sound/soc/omap/omap-mcbsp.h             |    2 +
>  4 files changed, 194 insertions(+), 30 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
