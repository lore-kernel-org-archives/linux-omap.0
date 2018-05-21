From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
Date: Mon, 21 May 2018 10:35:19 -0700
Message-ID: <20180521173519.GA98604@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180518 14:12]:
> Scope of the change is limited to GPIO pins used by board specific
> device drivers which will be updated by follow-up patches of the
> series. Those are some OMAP GPIO (gpio-0-15) and most of Amstrad Delta
> latch2 GPIO bank pins. Remaining pins of those banks, as well as
> Amstrad Delta latch1 pins, will be addressed later.
> 
> Assign a label ("latch2") to the bank, enumerate its pins and put that
> information, together with OMAP GPIO bank pins, in GPIO lookup tables.
> Assign lookup tables to devices as soon as those devices are registered
> and their names can be obtained.
> 
> A step froward in:
> - removal of hard-coded GPIO numbers from drivers,
> - removal of board mach includes from drivers,
> - switching to dynamically assigned GPIO numbers.

Is this first patch safe for me to apply separately?

Regards,

Tony
