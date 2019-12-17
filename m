From: Tony Lindgren <tony@atomide.com>
Subject: Re: TI omap compile problem in 5.5-rc1? was Re: [PATCH] ARM:
 davinci: select CONFIG_RESET_CONTROLLER
Date: Tue, 17 Dec 2019 08:46:40 -0800
Message-ID: <20191217164640.GX35479@atomide.com>
References: <20191210195202.622734-1-arnd@arndb.de>
 <20191217104520.GA6812@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217104520.GA6812@amd>
Sender: stable-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, Sekhar Nori <nsekhar@ti.com>, stable@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, David Lechner <david@lechnology.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191217 10:46]:
> Hi!
> 
> > Selecting RESET_CONTROLLER is actually required, otherwise we
> > can get a link failure in the clock driver:
> > 
> > drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> > psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_register'
> > drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> > psc-da850.c:(.text+0x24): undefined reference to
> > `reset_controller_add_lookup'
> 
> Does omap need similar handing in 5.5-rc1?
> 
>   LD      .tmp_vmlinux1
>   drivers/soc/ti/omap_prm.o: In function `omap_prm_probe':
>   omap_prm.c:(.text+0x4d0): undefined reference to
>   `devm_reset_controller_register'
>   /data/fast/l/k/Makefile:1077: recipe for target 'vmlinux' failed
>   make[1]: *** [vmlinux] Error 1
> 
> Enabling reset controller seems to help::
> 
> Reset Controller Support (RESET_CONTROLLER) [Y/n/?] (NEW)
>   TI SYSCON Reset Driver (RESET_TI_SYSCON) [N/m/y/?] (NEW)

Yes see the patch Arnd recently posted to do that.

Regards,

Tony
