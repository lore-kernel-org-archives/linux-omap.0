From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v6 10/10] clocksource: timer-dm: Check prescaler value
Date: Sun, 7 Jan 2018 21:26:44 +0530
Message-ID: <f743a25e-d29e-8693-f2c6-87d2f648d613@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
 <1514887799-24605-11-git-send-email-j-keerthy@ti.com>
 <20180104224713.GA11557@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180104224713.GA11557@lenoch>
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
To: Ladislav Michl <ladis@linux-mips.org>, daniel.lezcano@linaro.org
Cc: linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 1/5/2018 4:17 AM, Ladislav Michl wrote:
> On Tue, Jan 02, 2018 at 03:39:59PM +0530, Keerthy wrote:
>> From: Ladislav Michl <ladis@linux-mips.org>
>>
>> Invalid prescaler value is silently ignored. Fix that
>> by returning -EINVAL in such case. As invalid value
>> disabled use of the prescaler, use -1 explicitely for
>> that purpose.
>>
>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>> ---
>>   drivers/clocksource/timer-dm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
>> index 60db173..01a9cb0 100644
>> --- a/drivers/clocksource/timer-dm.c
>> +++ b/drivers/clocksource/timer-dm.c
>> @@ -672,6 +672,9 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
>>   	if (prescaler >= 0x00 && prescaler <= 0x07) {
>>   		l |= OMAP_TIMER_CTRL_PRE;
>>   		l |= prescaler << 2;
>> +	} else {
>> +		if (prescaler != -1)
>> +			return -EINVAL;
> 
> Argh... This is actually wrong, as it leaves timer enabled.
> I suggest simply dropping this patch and I'll rethink whole
> approach a bit later (and better).

Okay. I hope the rest 9 patches work well for you.

> 
>>   	}
>>   	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>>   
> 
> Sorry for the noise,
> 	ladis
> 
