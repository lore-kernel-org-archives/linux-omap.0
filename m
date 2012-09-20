From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/29] ARM: OMAP2+: Make board-zoom.h local
Date: Thu, 20 Sep 2012 10:15:34 -0700
Message-ID: <20120920171534.GC28835@atomide.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210554.28074.2280.stgit@muffinssi>
 <505AC5D3.1040907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <505AC5D3.1040907@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120920 00:29]:
> Hi Tony,
> 
> 
> On 09/20/2012 12:05 AM, Tony Lindgren wrote:
> > This can be local to mach-omap2 after we rip out the messed up
> > extmute stuff from board-zoom-peripherals.c that's all over
> > the place and probably does not even work because of all the
> > hardcoded GPIO numbers.
> > 
> > I also suggest ASoC gusy remove all extmute handling from
> > sound/soc/codecs/twl4030.c unless it's been tested to work
> > and implemented in a saner way.
> 
> I just wanted to note that I also have pending patch for zoom2.c as part of
> the twl4030 audio module DT support series:
> http://lkml.indiana.edu/hypermail/linux/kernel/1209.1/00711.html

Oh great, that makes it quite a bit saner. I'll drop this
for now as after your patch I can just move it.

Regards,

Tony
