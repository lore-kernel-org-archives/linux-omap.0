From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to
 mach
Date: Thu, 20 Sep 2012 10:10:54 -0700
Message-ID: <20120920171054.GA28835@atomide.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
 <6194989.y5R5mbkCAc@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6194989.y5R5mbkCAc@acer>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120920 06:48]:
> On Wed, 19 Sep 2012 14:05:43 Tony Lindgren wrote:
> > This is only used by omap1.
> > 
> > And to fix things properly, this should not be included
> > from the drivers at all.
> 
> Akced-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> I'll take care of updating the drivers when I have some spare time.

Thanks those can be fixed by passing them in the platform data.

Regards,

Tony
