From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Wed, 22 Apr 2015 01:41:39 +0200
Message-ID: <20150421234139.GF8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429577494-15087-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 20/04/2015 at 19:51:34 -0500, Nishanth Menon wrote :
> Alarm interrupt enable register is at offset 0x7, while the time
> registers for the alarm follow that. When we program Alarm interrupt
> enable prior to programming the time, it is possible that previous
> time value could be close or match at the time of alarm enable
> resulting in interrupt trigger which is unexpected (and does not match
> the time we expect it to trigger).
> 
> To prevent this scenario from occuring, program the ALM0_EN bit only
> after the alarm time is appropriately programmed.
> 
> Ofcourse, I2C programming is non-atomic, so there are loopholes where
> the interrupt wont trigger if the time requested is in the past at
> the time of programming the ALM0_EN bit. However, we will not have
> unexpected interrupts while the time is programmed after the interrupt
> are enabled.
> 

Do you have more details about the issue you are trying to solve?

Consider the following use case: a platform is setting the RTC alarm
before going to suspend to ram. Before your patch, it may be woken up
quite quickly, before expected. After your patch, it may never wake at
all.


> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in v2:
> 	- minor typo fix in comments
> 	- merged up code that I missed committing in
> 
> V1: https://patchwork.kernel.org/patch/6245041/
> 
>  drivers/rtc/rtc-ds1307.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4ffabb322a9a..3cd4783375a5 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -742,17 +742,17 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
>  	/* Set alarm match: second, minute, hour, day, date, month. */
>  	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
> -
> -	if (t->enabled)
> -		regs[0] |= MCP794XX_BIT_ALM0_EN;
> -	else
> -		regs[0] &= ~MCP794XX_BIT_ALM0_EN;
> +	/* Disable interrupt. We will not enable until completely programmed */
> +	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>  
>  	ret = ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10, regs);
>  	if (ret < 0)
>  		return ret;
>  
> -	return 0;
> +	if (!t->enabled)
> +		return 0;
> +	regs[0] |= MCP794XX_BIT_ALM0_EN;
> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, regs[0]);
>  }
>  
>  static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
