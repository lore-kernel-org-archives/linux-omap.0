From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm after
 programming time
Date: Mon, 20 Apr 2015 19:24:54 -0500
Message-ID: <553598D6.5030000@ti.com>
References: <1429574122-4284-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429574122-4284-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On 04/20/2015 06:55 PM, Nishanth Menon wrote:
> Alarm interrupt enable register is at offset 0x7, while the time
> registers for the alarm follow that. When we program Alarm interrupt
> enable prior to programming the time, it is possible that previous
> time value could be close or match at the time of alarm enable
> resulting in interrupt trigger which is unexpected (and does not match
> the time we expect it to trigger).
> 
> To prevent this scenario from occurring, program the ALM0_EN bit only
> after the alarm time is appropriately programmed.
> 
> Of course, I2C programming is non-atomic, so there are loopholes where
> the interrupt wont trigger if the time requested is in the past at
> the time of programming the ALM0_EN bit. However, we will not have
> unexpected interrupts while the time is programmed after the interrupt
> are enabled.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4ffabb322a9a..59f9ecf323d5 100644
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
> +	/* Disable interrupt. We will not enable until completely programed */
^^ typo here. s/programed/programmed
> +	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>  
>  	ret = ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10, regs);
>  	if (ret < 0)
>  		return ret;
>  
> -	return 0;
> +	if (!t->enabled)
> +		return 0;
> +	regs[0] |= MCP7941X_BIT_ALM0_EN;

^^ messed up git commit --amend :(

> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, regs[0]);
>  }
>  
>  static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
> 

will repost a rev2 - apologies on the noise.
-- 
Regards,
Nishanth Menon
