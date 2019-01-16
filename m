From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Wed, 16 Jan 2019 07:43:11 -0800
Message-ID: <20190116154311.GP5544@atomide.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116113723.15668-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [190116 11:37]:
> During "wlan-up", we are programming the FW into the WiFi-chip. However,
> re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> is made in-between the programmings.
> 
> To conform to this requirement and to fix the regression in a simple way,
> let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> current code is to treat this scenario as an error, but unfortunate this
> doesn't work as expected, so let's fix this.
> 
> The other part is to guarantee that a power cycle of the SDIO card has been
> completed when wl12xx_sdio_power_on() returns, as to allow the FW
> programming to succeed. However, relying solely on runtime PM to deal with
> this isn't sufficient. For example, userspace may prevent runtime suspend
> via sysfs for the device that represents the SDIO card, leading to that the
> mmc core also keeps it powered on. For this reason, let's instead do a
> brute force power cycle in wl12xx_sdio_power_on().
> 
> Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Keep the SDIO host claimed when calling mmc_hw_reset().
> 	- Add a fixes tag.

This v2 version works for me as tested with:

# while [ 1 ]; do ifconfig wlan0 down; ifconfig wlan0 up; done
[  181.364990] wlcore: down
[  182.116424] wlcore: firmware booted (Rev 6.3.10.0.141)
[  182.151641] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  182.166778] wlcore: down
[  182.773132] wlcore: firmware booted (Rev 6.3.10.0.141)
[  182.811096] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
...

Thanks for fixing this issue properly, and feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
