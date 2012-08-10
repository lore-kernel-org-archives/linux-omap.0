From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: twl-common: Add helper
 function to register the omap-twl4030 audio driver
Date: Thu, 9 Aug 2012 23:29:17 -0700
Message-ID: <20120810062916.GP11011@atomide.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <1344419650-5389-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1344419650-5389-3-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:54]:
> Since several OMAP3 based boards will be using the unified simple audio
> driver it is better to not have duplicated code in the board files for this
> purpose.
> Board files can call omap_twl4030_audio_init(); to set up the needed device
> for the audio support.
> 
> For example:
> omap_twl4030_audio_init("omap3beagle", 26000000);

Acked-by: Tony Lindgren <tony@atomide.com>
