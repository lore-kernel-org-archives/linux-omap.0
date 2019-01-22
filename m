From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Tue, 22 Jan 2019 16:24:21 +0000 (UTC)
Message-ID: <20190122162421.A2EFE609C2@smtp.codeaurora.org>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116113723.15668-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> wrote:

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
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to wireless-drivers.git, thanks.

13e62626c578 wlcore: sdio: Fixup power on/off sequence

-- 
https://patchwork.kernel.org/patch/10765781/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
