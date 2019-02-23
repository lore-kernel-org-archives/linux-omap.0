From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Date: Sat, 23 Feb 2019 10:23:23 -0800
Message-ID: <20190223182323.GA39872@atomide.com>
References: <20190223114754.16286-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190223114754.16286-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190223 11:48]:
> Since commit
> 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
> on gta04 we have handle_twl4030_pih() called in situations where pm_runtime_get()
> in i2c-omap.c returns -EACCES.
> [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
> [   86.555572] Disabling non-boot CPUs ...
> [   86.555664] Successfully put all powerdomains to target state
> [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563751] twl4030: I2C error -13 reading PIH ISR
> [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563812] twl4030: I2C error -13 reading PIH ISR
> [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563903] twl4030: I2C error -13 reading PIH ISR
> 
> This happens when we wakeup via something behing twl4030
> (powerbutton or rtc alarm).
> This goes on for minutes until the system is finally resumed.
> Disable the irq on suspend and enable it on resume to avoid
> having i2c access problems when the irq registers are checked.

Thanks for fixing this, still works fine for me for rtcwake:

Tested-by: Tony Lindgren <tony@atomide.com>
