From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] rtc: ds1307: Fix alarm programming for mcp794xx
Date: Sat, 24 Oct 2015 09:44:37 -0500
Message-ID: <562B9955.40308@ti.com>
References: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/23/2015 01:29 AM, Tero Kristo wrote:
> mcp794xx alarm registers must be written in BCD format. However, the
> alarm programming logic neglected this by adding one to the value
> after bin2bcd conversion has been already done, writing bad values
> to month register in case the alarm being set is in October. In this
> case, the alarm month value becomes 0x0a instead of the expected 0x10.
> 
> Fix by moving the +1 addition within the bin2bcd call also.
> 
> Fixes: 1d1945d261a2 ("drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips")
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Nice catch.
Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index a705e64..188006c 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -718,9 +718,9 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	regs[3] = bin2bcd(t->time.tm_sec);
>  	regs[4] = bin2bcd(t->time.tm_min);
>  	regs[5] = bin2bcd(t->time.tm_hour);
> -	regs[6] = bin2bcd(t->time.tm_wday) + 1;
> +	regs[6] = bin2bcd(t->time.tm_wday + 1);
>  	regs[7] = bin2bcd(t->time.tm_mday);
> -	regs[8] = bin2bcd(t->time.tm_mon) + 1;
> +	regs[8] = bin2bcd(t->time.tm_mon + 1);
>  
>  	/* Clear the alarm 0 interrupt flag. */
>  	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
> 


-- 
Regards,
Nishanth Menon
