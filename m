From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] ASoC/OMAP: ASoC machine driver for
 simple SoC with twl4030
Date: Thu, 9 Aug 2012 23:32:10 -0700
Message-ID: <20120810063209.GR11011@atomide.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <20120808132741.GX16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120808132741.GX16861@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120808 06:27]:
> On Wed, Aug 08, 2012 at 12:54:06PM +0300, Peter Ujfalusi wrote:
> 
> > Changes under arch/arm/mach-omap2/ are trivial, I don't expect merge issues
> > later. If it is OK for the maintainers I would like this to go via audio tree
> > (with the McBSP and the twl4030-audio stack DT support).
> 
> This all looks OK to me, again if it gets applied via ASoC I'll put it
> on a separate branch so if we do need to get into OMAP as well it's easy
> to do so.

I've acked the omap related patches so when the other changes
comments are dealt with, please feel free to merge via ASoC tree.

Regards,

Tony
