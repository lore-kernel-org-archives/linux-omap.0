From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform
	data
Date: Wed, 1 Jun 2011 06:00:34 -0700
Message-ID: <20110601130034.GE11352@atomide.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
	<1306927051-8937-4-git-send-email-peter.ujfalusi@ti.com>
	<20110601120754.GC11352@atomide.com>
	<201106011554.53090.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201106011554.53090.peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110601 05:50]:
> On Wednesday 01 June 2011 15:07:54 Tony Lindgren wrote:
> > 
> > Can you please take a look at creating arch/arm/mach-omap2/i2c-twl.c or
> > something in common-board-devices.c to get rid of the cut and paste
> > duplication in every board-*.c file?
> 
> Yes, it would make sense, since most of the board has similar configuration, 
> and we have lots of duplicated code around.
>  
> > Maybe you could have a generic twl_init function that allows overriding
> > things like keypad with board specific configuration?
> 
> We might need also support for overriding other configurations 
> (audio/codec/vibra for sure needs that).

Yeah, most of it might be possible to describe with just a flags
like TWL_HAS_VIBRA etc.
 
> I'll take a look, but I think it is not going to be part of v2 of this series.

We should not do renaming before the clean-up though, it gets
classified as "unnecesary churn".

Tony
