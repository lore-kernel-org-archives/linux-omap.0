From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/29] ARM: OMAP2+: Make board-zoom.h local
Date: Wed, 19 Sep 2012 21:24:34 -0400
Message-ID: <20120920012433.GC17666@opensource.wolfsonmicro.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210554.28074.2280.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120919210554.28074.2280.stgit@muffinssi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 19, 2012 at 02:05:54PM -0700, Tony Lindgren wrote:
> This can be local to mach-omap2 after we rip out the messed up
> extmute stuff from board-zoom-peripherals.c that's all over
> the place and probably does not even work because of all the
> hardcoded GPIO numbers.
> 
> I also suggest ASoC gusy remove all extmute handling from
> sound/soc/codecs/twl4030.c unless it's been tested to work
> and implemented in a saner way.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

or I can apply it if that's easier.
