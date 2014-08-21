From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
Date: Thu, 21 Aug 2014 12:12:49 -0500
Message-ID: <53F62891.1000005@ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com> <1408636935-29515-1-git-send-email-nm@ti.com> <1408636935-29515-3-git-send-email-nm@ti.com> <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/21/2014 11:59 AM, Murphy, Dan wrote:
Thanks for the review.
[..]
>> +#include <linux/init.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/palmas.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
> 
> I don't see any reboot calls made do we need this?

Arrgh.. yes. will drop.

[..]

>> +/**
>> + * palmas_pwron_params_ofinit() - device tree parameter parser
>> + * @dev:	palmas button device
>> + * @config:	configuration params that this fills up
>> + */
>> +static void palmas_pwron_params_ofinit(struct device *dev,
>> +				       struct palmas_pwron_config *config)
> 
> Maybe we should change this to return an int so that if the DT is not populated
> then the LPK and debounce is not set but we continue anyway.

Why? these are optional properties, the defaults are 12 seconds for
LPK and 15 ms for debounce. there is no reason for it to return an
error value at this point.

> 
> Is there support for platform data itself?

No platform data support. The driver can function without these
properties - these are not mandatory.

>> +{
>> +	struct device_node *np;
>> +	u32 val;
>> +	int i;
>> +	u8 lpk_times[] = { 6, 8, 10, 12 };
>> +	int pwr_on_deb_ms[] = { 15, 100, 500, 1000 };
>> +
>> +	/* Legacy boot? */
>> +	if (!of_have_populated_dt())
>> +		return;
>> +
>> +	np = of_node_get(dev->of_node);
>> +	/* Mixed boot? */
> 
> Can we expand a little on Mixed boot vs legacy boot?

Are you looking for "device tree + platform boot" ? legacy boot being
"non device tree boot"?
>> +
>> +	val = 0;
> 
> Is this necessary?
> 
>> +	of_property_read_u32(np, "ti,palmas-long-press-seconds", &val);
> 
> Probably should check the return to make sure the value exists and that is is
> within an expected range.  Since this is an optional parameter it may not be
> populated.  And below it sets a preliminary value to the max as the default.
> 
> Maybe the default setting should be set at the beginning of this function so
> that if there is no dt data then at least the values will be defaulted.
> 
>> +	config->long_press_time_val = ARRAY_SIZE(lpk_times) - 1;
>> +	for (i = 0; i < ARRAY_SIZE(lpk_times); i++) {
>> +		if (val <= lpk_times[i]) {
>> +			config->long_press_time_val = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	val = 0;
> 
> Don't think we need this either if we check the return on the call
> below.

k, I can redo the sequence a little better here.

> 
>> +	of_property_read_u32(np, "ti,palmas-pwron-debounce-milli-seconds",
>> +			     &val);
> 
> 
> Probably should check the return to make sure the value exists and that is is
> within an expected range.

Not necessary.
> 
>> +	config->pwron_debounce_val = 0;
> 
> Should this not have been 0 anyway?

it is, was explicit in this case.
> 
>> +	for (i = 0; i < ARRAY_SIZE(pwr_on_deb_ms); i++) {
>> +		if (val <= pwr_on_deb_ms[i]) {
>> +			config->pwron_debounce_val = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	dev_info(dev, "h/w controlled shutdown duration=%d seconds\n",
>> +		 lpk_times[config->long_press_time_val]);
>> +
>> +	of_node_put(np);
>> +}
>> +
[...]

-- 
Regards,
Nishanth Menon
