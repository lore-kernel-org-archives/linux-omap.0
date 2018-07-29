From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
Date: Sun, 29 Jul 2018 08:32:41 +0200
Message-ID: <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info> <20180728203501.GA16194@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180728203501.GA16194@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, Andreas Kemnade <andreas@kemnade.info>, David Rivshin <drivshin@allworx.com>
Cc: linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> 
> Hi Andreas,
> 
> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:
>> I got this in the kernel log:
>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
>> 
>> the probe function has to wait until omap_dm_timer_probe() in
>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing
> 
> There already is a patch by David Rivshin addressing the same issue...

Here it is:

https://patchwork.ozlabs.org/patch/943148/

but hasn't arrived in linux-next.

But it is questionable if a driver should dev_info() about doing deferred probing.
IMHO, it should just do it which is how Andreas' patch works.

> 
>> Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>> drivers/pwm/pwm-omap-dmtimer.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index 665da3c8fbce..808835179c2e 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>> 
>> 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>> 	if (!timer_pdata) {
>> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
>> -		ret = -EINVAL;
>> +		ret = -EPROBE_DEFER;
>> 		goto put;
>> 	}
>> 
>> -- 
>> 2.11.0
>> 

BR,
Nikolaus
