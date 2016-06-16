From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v2 4/5] mfd: tps65217: Add power button as subdevice
Date: Thu, 16 Jun 2016 13:43:51 +0200
Message-ID: <936f74b4-9446-c49e-56c1-98dfa6d774b9@grinn-global.com>
References: <20160614132927.3309-1-m.niestroj@grinn-global.com>
 <20160614132927.3309-5-m.niestroj@grinn-global.com>
 <20160615141242.GK4948@dell>
 <61c57049-04e3-434c-6293-58a9297c73c9@grinn-global.com>
 <20160616103622.GS4948@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160616103622.GS4948@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 16.06.2016 12:36, Lee Jones wrote:
> On Wed, 15 Jun 2016, Marcin Niestroj wrote:
>
>> Hi,
>>
>> On 15.06.2016 16:12, Lee Jones wrote:
>>> On Tue, 14 Jun 2016, Marcin Niestroj wrote:
>>>
>>>> Add tps65217 power buttor subdevice with assigned IRQ resources.
>>>>
>>>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>>>> ---
>>>> depends on patch 1 in series
>>>>
>>>> drivers/mfd/tps65217.c | 10 ++++++++++
>>>> 1 file changed, 10 insertions(+)
>>>
>>> Applied, thanks.
>>
>> Did you also apply patch 1? As I stated above, this patch depends on
>> patch 1.
>
> Nope.  It looks like you still have changes to make.
>
> What does it rely on?  The IRQ define?

Yes, TPS65217_IRQ_PB is an enum declared in patch 1.

I have just send new version of the whole patch series including your
suggestions.

>
>>>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>>>> index d49f94e..68cf431 100644
>>>> --- a/drivers/mfd/tps65217.c
>>>> +++ b/drivers/mfd/tps65217.c
>>>> @@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
>>>> 	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>>>> };
>>>>
>>>> +static struct resource pb_resources[] = {
>>>> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>>>> +};
>>>> +
>>>> struct tps65217_irq {
>>>> 	int mask;
>>>> 	int interrupt;
>>>> @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
>>>> 		.resources = charger_resources,
>>>> 		.of_compatible = "ti,tps65217-charger",
>>>> 	},
>>>> +	{
>>>> +		.name = "tps65217-pwrbutton",
>>>> +		.num_resources = ARRAY_SIZE(pb_resources),
>>>> +		.resources = pb_resources,
>>>> +		.of_compatible = "ti,tps65217-pwrbutton",
>>>> +	},
>>>> };
>>>>
>>>> static irqreturn_t tps65217_irq_thread(int irq, void *data)
>>>
>>
>

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
