From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Mon, 21 Jan 2019 11:30:42 -0800
Message-ID: <20190121193042.GF5544@atomide.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
 <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de>
 <CAPDyKFoqfyvQRnSBRvPVxrL-nmf1YoSzxRkPfGwr==L3LOwgaw@mail.gmail.com>
 <5bf8514a-eb15-b098-1857-835b36d4a67c@web.de>
 <CAPDyKFo=m50jiQ639xzP9tzn+=Bn0CXXwO6p0_jPH0EnSc0UQg@mail.gmail.com>
 <CAPDyKFrt3+i83x_qyTrVVCSxda_+3HpJPR6RuPBxzRHnZTRVvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrt3+i83x_qyTrVVCSxda_+3HpJPR6RuPBxzRHnZTRVvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [190121 06:41]:
> So, I have put together a debug patch, mostly to verify that things
> seems to be correct in regards to runtime PM. It should produce some
> prints to the log, particular during power on/off of the SDIO card and
> during probe of the wifi driver. Please re-run the test on top of the
> v2 version of the $subject patch.

For reference, here's what I'm seeing on omap4 with your v2 fix
and the debug patch for:

# ifconfig wlan0 up; ifconfig wlan0 down

Note that this is without pwrseq, so maybe that's the difference.

Regards,

Tony

8< -----------------
[  148.458282] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_on: STEP1
[  148.464691] mmc mmc4:0001: mmc_sdio_runtime_resume
[  148.641021] mmc mmc4:0001: mmc_sdio_runtime_resume - ret=0 DONE
[  148.647613] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_on: STEP2
[  148.653961] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_on: STEP3
[  148.660430] mmc mmc4:0001: mmc_sdio_hw_reset
[  148.828735] mmc mmc4:0001: mmc_sdio_hw_reset - ret=0 DONE
[  148.834503] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_on: STEP4
[  148.840789] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_on: STEP5
[  149.194671] wlcore: firmware booted (Rev 7.3.10.0.141)
[  149.200134] wl1271_sdio mmc4:0001:2: sdio_bus_runtime_resume
[  149.233276] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  149.248352] wlcore: down
[  149.253082] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_off: STEP1
[  149.259613] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_off: STEP2
[  149.265869] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_off: STEP3
[  149.272155] wl1271_sdio mmc4:0001:2: wl12xx_sdio_power_off: STEP4
[  149.307952] wl1271_sdio mmc4:0001:2: sdio_bus_runtime_suspend
[  149.314147] mmc mmc4:0001: mmc_sdio_runtime_suspend
[  149.321136] mmc mmc4:0001: mmc_sdio_runtime_suspend - DONE
