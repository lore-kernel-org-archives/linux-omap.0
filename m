From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Date: Tue, 2 Apr 2019 04:52:44 +0100
Message-ID: <20190402035244.GI4187@dell>
References: <20190223114754.16286-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190223114754.16286-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Sat, 23 Feb 2019, Andreas Kemnade wrote:

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
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
