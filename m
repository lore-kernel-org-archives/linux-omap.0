From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
Date: Wed, 22 Jul 2015 10:54:25 +0530
Message-ID: <55AF2909.5090609@ti.com>
References: <1437367814-27785-1-git-send-email-vigneshr@ti.com> <1437367814-27785-2-git-send-email-vigneshr@ti.com> <20150720060929.GW17550@atomide.com> <20150720062407.GA13092@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20150720062407.GA13092@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Roger Quadros <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On 07/20/2015 11:54 AM, Dmitry Torokhov wrote:
> On Sun, Jul 19, 2015 at 11:09:30PM -0700, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [150719 21:53]:
>>> @@ -445,6 +443,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>>>  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
>>>  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
>>>  
>>> +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeupirq");
>>> +
>>>  	return pdata;
>>
>> What about handling -EPROVE_DEFER here? At least pinctrl-single can be
>> be a loadable module for the dedicated wakeirqs.
> 
> Right. I think we should only allow -ENODATA to continue and return
> error in all other cases.

-EINVAL will be returned if "interrupt-names" is not specified. I will
make execption for -ENODATA & -EINVAL, and return error in all other cases?

> 
> Also, I think "irq" suffix on name is redundant.

Ok, will drop "irq" suffix:

+		interrupt-names = "tsc", "wakeup";

> 
> Thanks.
> 

-- 
Regards
Vignesh
