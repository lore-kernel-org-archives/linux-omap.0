From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] wlcore: sdio: Fixup power on/off sequence
Date: Tue, 15 Jan 2019 10:55:09 -0800
Message-ID: <20190115185509.GJ5544@atomide.com>
References: <20190115150433.12558-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115150433.12558-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Ulf Hansson <ulf.hansson@linaro.org> [190115 15:04]:
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

Thanks this looks good.. But looks like udelay 20000
is needed with:

# while [ 1 ]; do ifconfig wlan0 down; usleep 20000; \
  ifconfig wlan0 up; done

Otherwise I get the following on warning pandaboard-es:

WARNING: CPU: 0 PID: 1770 at drivers/bus/omap_l3_noc.c:147
l3_interrupt_handler+0x2f8/0x388
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Read):
Data Access in User mode during Functional access

Meaning that we access registers while not clocked
somewhere. I think that warning is different from the
earlier errors though :) And we could add a msleep(50)
to the end to mostly avoid it until we have a better
fix available?

Regards,

Tony
