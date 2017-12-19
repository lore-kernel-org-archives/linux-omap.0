From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2] clocksource: timer-dm: Check prescaler value
Date: Tue, 19 Dec 2017 14:00:52 +0530
Message-ID: <f3c92557-f3e9-9ea7-ad1f-c6e8924d9ee2@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch> <20171218113153.GB18637@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171218113153.GB18637@lenoch>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux@armlinux.org.uk, t-kristo@ti.com, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Monday 18 December 2017 05:01 PM, Ladislav Michl wrote:
> Invalid prescaler value is silently ignored. Fix that
> by returning -EINVAL in such case. As invalid value
> disabled use of the prescaler, use -1 explicitely for
> that purpose.

Thanks. I will post this as part of my migration series.

> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/clocksource/timer-dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index ec3a28c90c70..95cd98be8541 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -609,6 +609,9 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
>  	if (prescaler >= 0x00 && prescaler <= 0x07) {
>  		l |= OMAP_TIMER_CTRL_PRE;
>  		l |= prescaler << 2;
> +	} else {
> +		if (prescaler != -1)
> +			return -EINVAL;
>  	}
>  	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>  
> 
