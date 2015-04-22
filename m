From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Wed, 22 Apr 2015 16:26:01 +0300
Message-ID: <5537A169.206@linaro.org>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33612 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbbDVN0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 09:26:06 -0400
Received: by lbbzk7 with SMTP id zk7so180058840lbb.0
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2015 06:26:05 -0700 (PDT)
In-Reply-To: <1429577494-15087-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com

Hi,

On 04/21/2015 03:51 AM, Nishanth Menon wrote:
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

I think it will be nice if you will mention that you going to follow
vendor recommendations - AN1491 Configuring the MCP794XX RTCC Family
http://ww1.microchip.com/downloads/en/AppNotes/01491A.pdf
;)
"Also, it is recommended that the alarm registers be loaded
before the alarm is enabled."

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in v2:
> 	- minor typo fix in comments
> 	- merged up code that I missed committing in
> 
> V1: https://patchwork.kernel.org/patch/6245041/
> 
>   drivers/rtc/rtc-ds1307.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4ffabb322a9a..3cd4783375a5 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -742,17 +742,17 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>   	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
>   	/* Set alarm match: second, minute, hour, day, date, month. */
>   	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
> -
> -	if (t->enabled)
> -		regs[0] |= MCP794XX_BIT_ALM0_EN;
> -	else
> -		regs[0] &= ~MCP794XX_BIT_ALM0_EN;
> +	/* Disable interrupt. We will not enable until completely programmed */
> +	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>   
>   	ret = ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10, regs);
>   	if (ret < 0)
>   		return ret;
>   
> -	return 0;
> +	if (!t->enabled)
> +		return 0;
> +	regs[0] |= MCP794XX_BIT_ALM0_EN;
> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, regs[0]);

So, It seems, that right sequence should be:
- disable alarmX
- read alarmX regs
- configure alarmX regs
- load alarmX regs
- enable alarmX

More over, looks like, alarm/alarm IRQ should be enabled/disabled separately from set_alarm/RTC_ALM_SET
by RTC_AIE_ON, RTC_AIE_OFF. Should it?

>   }
>   
>   static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
> 


-- 
regards,
-grygorii
