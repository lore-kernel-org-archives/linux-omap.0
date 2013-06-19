From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 5/5] i2c: omap: remove omap_i2c_isr() hw irq handler
Date: Wed, 19 Jun 2013 21:43:17 +0300
Message-ID: <51C1FBC5.1030109@ti.com>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com> <1370630768-4077-6-git-send-email-grygorii.strashko@ti.com> <20130607190750.GF15295@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130607190750.GF15295@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 06/07/2013 10:07 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Jun 07, 2013 at 09:46:08PM +0300, Grygorii Strashko wrote:
>> The omap_i2c_isr() does the irq check and schedules threaded handler if any of
>> enabled IRQs is active, but currently the I2C IRQs are enabled just once,
>> when I2C IP is enabling (transfer started) and they aren't changed after that.
>> More over, now the I2C INTC IRQ is disabled when I2C IP is idled.
>> Thus, I2C IRQs will start coming only when we want that, and there is
>> no sense to have omap_i2c_isr() anymore:
> so ? we still want to check if this device generated IRQs in hardirq
> context. What if the IRQ line is shared ?
>
Pleas see, https://patchwork.kernel.org/patch/2689211/
[1/5] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC when idle

It covers shared IRQ problem

Sorry, for delayed reply - I've had problems with my e-mail.

- grygorii
