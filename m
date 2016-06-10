From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/7] ARM: OMAP3: hwmod data: Fix
	McBSP2/3 sidetone data
Date: Fri, 10 Jun 2016 05:08:30 -0700
Message-ID: <20160610120830.GM22406@atomide.com>
References: <20160530082350.24285-1-peter.ujfalusi@ti.com>
 <20160530082350.24285-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160530082350.24285-3-peter.ujfalusi@ti.com>
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
Cc: devicetree@vger.kernel.org, paul@pwsan.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160530 01:26]:
> The McBSPLP's sidetone main clock is the McBSPLP's ICLK, not FCLK as the
> sidetone only receives the ICLK from the main McBSP module.
> Since the McBSP and sidetone is using the very same clock from PRCM level
> the sidetone must not have the prcm section to check the clock status since
> the sidetone is only used when McBSP is already configured.
> If two separate hwmods looking at the same bit and they would use
> pm_runtime in nested way (as it must happen with McBSP and it's ST module)
> the hwmod would warn, because the idlest will not match what it is expected
> after enable/disable of the clocks.

OK thanks for fixing this. I'm applying patches 2-7 into
omap-for-v4.8/soc.

Regards,

Tony
