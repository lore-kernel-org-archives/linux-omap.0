From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: menelaus: fix possible race condition and leak
Date: Tue, 11 Sep 2018 16:39:54 +0100
Message-ID: <20180911153954.GA4185@dell>
References: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 09 Sep 2018, Alexandre Belloni wrote:

> The IRQ work is added before the struct rtc is allocated and registered,
> but this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before calling menelaus_add_irq_work.
> 
> Also, this solves a possible leak as the RTC is never released.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Lee,
> 
> If that is ok with you, I would like to take this patch through the RTC
> tree. So I can have a follow up patch removing rtc_device_register().
> 
> Thanks
> 
>  drivers/mfd/menelaus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
