From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 15 Nov 2015 12:34:27 +0100
Message-ID: <791498DF-F1B5-492A-994D-BB3D8B14F2BF@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com> <ad1d3042c80142a59ab883fe17fe950dea734d94.1447446957.git.hns@goldelico.com> <20151115021437.GA23287@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151115021437.GA23287@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Am 15.11.2015 um 03:14 schrieb Rob Herring <robh@kernel.org>:

> On Fri, Nov 13, 2015 at 09:35:52PM +0100, H. Nikolaus Schaller wrote:
>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
>> introduced common DT bindings for touchscreens [1] and a helper function to
>> parse the DT.
>> 
>> This has been integrated and interpretation of the inversion (flipping)
>> properties for the x and y axis has been added to accommodate any
>> orientation of the touch in relation to the LCD.
>> 
>> By scaling the min/max ADC values to the screen size it is now possible to
>> pre-calibrate the touch so that is (almost) exactly matches the LCD it is
>> glued onto. This allows to well enough operate the touch before a user
>> space calibration can improve the precision.
>> 
>> calculate_pressure has been renamed to calculate_resistance because
>> that is what it is doing.
>> 
>> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> This still looks like it will break with old dtbs. It doesn't matter if 
> you update the in tree dts files, you should not force users to update 
> their dtb.

I have studied the situation a little more and there is also a real bug involved.

The unpatched tsc2007 driver reports "touch resistance" as "pressure" to the input
layer by default.

I.e. if you touch, you will get the pressure value jump from 0 to a maximum value
and the more you press, the value goes down. This is opposite of what the tsc2046
driver reports (and most user-space code would assume).

Our patch fixes that as a side-effect (we forgot to mention it explicitly) unless
you explicitly specify "ti,report-resistance" which restores the old behaviour.

Basically this property should not be needed in normal operation.

So if we do it the way we do, old dtbs still work but no longer report "resistance"
but "pressure".

And only if the user space gets problems with that (most code I know just decides
between 0 and >0), the dts can be augmented by "ti,report-resistance" and recompiled
to report the resistance value. Maybe, this could even be achieved by a dt overlay if
the dts is not available for modifications.

The other properties (all min/max values) have the same defaults as without
this patch set (0 / 4095). Old dtbs should therefore work unchanged. And in the
worst case may need recalibration in user-space.

This is the way we were thinking when designing this patch.

So I think we should just better describe this bug fix and how to restore the old behaviour.

BR and thanks,
Nikolaus


> 
> Rob
> 
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../bindings/input/touchscreen/tsc2007.txt         |  20 +--
>> drivers/input/touchscreen/tsc2007.c                | 135 +++++++++++++++++----
>> include/linux/i2c/tsc2007.h                        |   8 ++
>> 3 files changed, 135 insertions(+), 28 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> index ec365e1..6e9fd55 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> @@ -6,6 +6,7 @@ Required properties:
>> - ti,x-plate-ohms: X-plate resistance in ohms.
>> 
>> Optional properties:
>> +- generic touch screen properties: see touchscreen binding [2].
>> - gpios: the interrupt gpio the chip is connected to (trough the penirq pin).
>>   The penirq pin goes to low when the panel is touched.
>>   (see GPIO binding[1] for more details).
>> @@ -13,17 +14,20 @@ Optional properties:
>>   (see interrupt binding[0]).
>> - interrupts: (gpio) interrupt to which the chip is connected
>>   (see interrupt binding[0]).
>> -- ti,max-rt: maximum pressure.
>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>> -  If set, it will permit noise in the data up to +- the value given to the fuzz
>> -  parameter, that is used to filter noise from the event stream.
>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>> -- ti,fuzzz: specifies the absolute input fuzz z value.
>> +- ti,max-rt: maximum pressure resistance above which samples are ignored
>> +  (default: 4095).
>> +- ti,report-resistance: report resistance (no pressure = max_rt) instead
>> +  of pressure (no pressure = 0).
>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>> - ti,poll-period: how much time to wait (in milliseconds) before reading again the
>> -  values from the tsc2007.
>> +  values from the tsc2007 (default 1).
>> 
>> [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> [1]: Documentation/devicetree/bindings/gpio/gpio.txt
>> +[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> 
>> Example:
>> 	&i2c1 {
>> @@ -35,6 +39,8 @@ Example:
>> 			interrupts = <0x0 0x8>;
>> 			gpios = <&gpio4 0 0>;
>> 			ti,x-plate-ohms = <180>;
>> +			touchscreen-size-x = <640>;
>> +			touchscreen-size-y = <480>;
>> 		};
>> 
>> 		/* ... */
>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
>> index 5d0cd51..e0c7173 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>> @@ -29,6 +29,7 @@
>> #include <linux/of_device.h>
>> #include <linux/of.h>
>> #include <linux/of_gpio.h>
>> +#include <linux/input/touchscreen.h>
>> 
>> #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>> #define TSC2007_MEASURE_AUX		(0x2 << 4)
>> @@ -74,6 +75,14 @@ struct tsc2007 {
>> 
>> 	u16			model;
>> 	u16			x_plate_ohms;
>> +	bool			swap_xy;
>> +	bool			invert_x;
>> +	bool			invert_y;
>> +	bool			report_resistance;
>> +	u16			min_x;
>> +	u16			min_y;
>> +	u16			max_x;
>> +	u16			max_y;
>> 	u16			max_rt;
>> 	unsigned long		poll_period; /* in jiffies */
>> 	int			fuzzx;
>> @@ -128,7 +137,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>> 	tsc2007_xfer(tsc, PWRDOWN);
>> }
>> 
>> -static u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
>> +static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>> +					struct ts_event *tc)
>> {
>> 	u32 rt = 0;
>> 
>> @@ -177,12 +187,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>> 	struct ts_event tc;
>> 	u32 rt;
>> 
>> +	dev_dbg(&ts->client->dev, "soft irq %d\n", irq);
>> 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>> 
>> 		/* pen is down, continue with the measurement */
>> 		tsc2007_read_values(ts, &tc);
>> 
>> -		rt = tsc2007_calculate_pressure(ts, &tc);
>> +		rt = tsc2007_calculate_resistance(ts, &tc);
>> 
>> 		if (!rt && !ts->get_pendown_state) {
>> 			/*
>> @@ -198,6 +209,48 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>> 				"DOWN point(%4d,%4d), pressure (%4u)\n",
>> 				tc.x, tc.y, rt);
>> 
>> +			/* clamp to expected ADC range */
>> +			if (tc.x < ts->min_x)
>> +				tc.x = ts->min_x;
>> +			if (tc.x > ts->max_x)
>> +				tc.x = ts->max_x;
>> +			if (tc.y < ts->min_y)
>> +				tc.y = ts->min_y;
>> +			if (tc.y > ts->max_y)
>> +				tc.y = ts->max_y;
>> +
>> +			dev_dbg(&ts->client->dev,
>> +					"Clamped point(%4d,%4d), pressure (%4u)\n",
>> +					tc.x, tc.y, rt);
>> +
>> +			/* flip */
>> +			if (ts->invert_x)
>> +				tc.x = (ts->max_x - tc.x) + ts->min_x;
>> +			if (ts->invert_y)
>> +				tc.y = (ts->max_y - tc.y) + ts->min_y;
>> +			if (!ts->report_resistance)
>> +				rt = ts->max_rt - rt;
>> +
>> +			dev_dbg(&ts->client->dev,
>> +					"Flipped point(%4d,%4d), pressure (%4u)\n",
>> +					tc.x, tc.y, rt);
>> +
>> +			/* scale to desired output range */
>> +			tc.x = (input->absinfo[ABS_X].maximum *
>> +				(tc.x - ts->min_x)) / (ts->max_x - ts->min_x);
>> +			tc.y = (input->absinfo[ABS_Y].maximum *
>> +				(tc.y - ts->min_y)) / (ts->max_y - ts->min_y);
>> +			rt = (input->absinfo[ABS_PRESSURE].maximum * rt)
>> +				/ ts->max_rt;
>> +
>> +			/* swap x and y */
>> +			if (ts->swap_xy)
>> +				swap(tc.x, tc.y);
>> +
>> +			/* report event */
>> +			dev_dbg(&ts->client->dev,
>> +					"shaped point(%4d,%4d), pressure (%4u)\n",
>> +					tc.x, tc.y, rt);
>> 			input_report_key(input, BTN_TOUCH, 1);
>> 			input_report_abs(input, ABS_X, tc.x);
>> 			input_report_abs(input, ABS_Y, tc.y);
>> @@ -207,8 +260,8 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>> 
>> 		} else {
>> 			/*
>> -			 * Sample found inconsistent by debouncing or pressure is
>> -			 * beyond the maximum. Don't report it to user space,
>> +			 * Sample found inconsistent by debouncing or resistance
>> +			 * is beyond the maximum. Don't report it to user space,
>> 			 * repeat at least once more the measurement.
>> 			 */
>> 			dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
>> @@ -233,6 +286,7 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
>> {
>> 	struct tsc2007 *ts = handle;
>> 
>> +	dev_dbg(&ts->client->dev, "hard irq %d\n", irq);
>> 	if (tsc2007_is_pen_down(ts))
>> 		return IRQ_WAKE_THREAD;
>> 
>> @@ -303,14 +357,25 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
>> 	else
>> 		ts->max_rt = MAX_12BIT;
>> 
>> -	if (!of_property_read_u32(np, "ti,fuzzx", &val32))
>> -		ts->fuzzx = val32;
>> +	ts->swap_xy = of_property_read_bool(np, "touchscreen-swapped-x-y");
>> +	ts->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
>> +	ts->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
>> +	ts->report_resistance =
>> +		       of_property_read_bool(np, "ti,report-resistance");
>> 
>> -	if (!of_property_read_u32(np, "ti,fuzzy", &val32))
>> -		ts->fuzzy = val32;
>> +	if (!of_property_read_u32(np, "ti,min-x", &val32))
>> +		ts->min_x = val32;
>> +	if (!of_property_read_u32(np, "ti,max-x", &val32))
>> +		ts->max_x = val32;
>> +	else
>> +		ts->max_x = MAX_12BIT;
>> 
>> -	if (!of_property_read_u32(np, "ti,fuzzz", &val32))
>> -		ts->fuzzz = val32;
>> +	if (!of_property_read_u32(np, "ti,min-y", &val32))
>> +		ts->min_y = val32;
>> +	if (!of_property_read_u32(np, "ti,max-y", &val32))
>> +		ts->max_y = val32;
>> +	else
>> +		ts->max_y = MAX_12BIT;
>> 
>> 	if (!of_property_read_u64(np, "ti,poll-period", &val64))
>> 		ts->poll_period = msecs_to_jiffies(val64);
>> @@ -324,6 +389,16 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
>> 		return -EINVAL;
>> 	}
>> 
>> +	dev_dbg(&client->dev,
>> +			"min/max_x (%4d,%4d)\n",
>> +			ts->min_x, ts->max_x);
>> +	dev_dbg(&client->dev,
>> +			"min/max_y (%4d,%4d)\n",
>> +			ts->min_y, ts->max_y);
>> +	dev_dbg(&client->dev,
>> +			"max_rt (%4d)\n",
>> +			ts->max_rt);
>> +
>> 	ts->gpio = of_get_gpio(np, 0);
>> 	if (gpio_is_valid(ts->gpio))
>> 		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
>> @@ -332,6 +407,10 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
>> 			 "GPIO not specified in DT (of_get_gpio returned %d)\n",
>> 			 ts->gpio);
>> 
>> +	dev_dbg(&client->dev,
>> +			"ts-gpio: %d\n",
>> +			ts->gpio);
>> +
>> 	return 0;
>> }
>> #else
>> @@ -349,6 +428,14 @@ static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc2007 *ts,
>> 	ts->model             = pdata->model;
>> 	ts->x_plate_ohms      = pdata->x_plate_ohms;
>> 	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
>> +	ts->swap_xy           = pdata->swap_xy;
>> +	ts->invert_x          = pdata->invert_x;
>> +	ts->invert_y          = pdata->invert_y;
>> +	ts->report_resistance = pdata->report_resistance;
>> +	ts->min_x             = pdata->min_x ? : 0;
>> +	ts->min_y             = pdata->min_y ? : 0;
>> +	ts->max_x             = pdata->max_x ? : MAX_12BIT;
>> +	ts->max_y             = pdata->max_y ? : MAX_12BIT;
>> 	ts->poll_period       = msecs_to_jiffies(pdata->poll_period ? : 1);
>> 	ts->get_pendown_state = pdata->get_pendown_state;
>> 	ts->clear_penirq      = pdata->clear_penirq;
>> @@ -388,13 +475,6 @@ static int tsc2007_probe(struct i2c_client *client,
>> 	if (!ts)
>> 		return -ENOMEM;
>> 
>> -	if (pdata)
>> -		err = tsc2007_probe_pdev(client, ts, pdata, id);
>> -	else
>> -		err = tsc2007_probe_dt(client, ts);
>> -	if (err)
>> -		return err;
>> -
>> 	input_dev = devm_input_allocate_device(&client->dev);
>> 	if (!input_dev)
>> 		return -ENOMEM;
>> @@ -421,10 +501,21 @@ static int tsc2007_probe(struct i2c_client *client,
>> 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>> 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>> 
>> -	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, 0);
>> -	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
>> -	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
>> -			     ts->fuzzz, 0);
>> +	if (pdata)
>> +		err = tsc2007_probe_pdev(client, ts, pdata, id);
>> +	else
>> +		err = tsc2007_probe_dt(client, ts);
>> +	if (err)
>> +		return err;
>> +
>> +	input_set_abs_params(input_dev, ABS_X, 0, ts->max_x-ts->min_x,
>> +						  ts->fuzzx, 0);
>> +	input_set_abs_params(input_dev, ABS_Y, 0, ts->max_y-ts->min_y,
>> +						  ts->fuzzy, 0);
>> +	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ts->max_rt,
>> +						  ts->fuzzz, 0);
>> +
>> +	touchscreen_parse_properties(input_dev, false);
>> 
>> 	if (pdata) {
>> 		if (pdata->exit_platform_hw) {
>> @@ -443,6 +534,8 @@ static int tsc2007_probe(struct i2c_client *client,
>> 			pdata->init_platform_hw();
>> 	}
>> 
>> +	dev_dbg(&client->dev, "request irq %d\n",
>> +			ts->irq);
>> 	err = devm_request_threaded_irq(&client->dev, ts->irq,
>> 					tsc2007_hard_irq, tsc2007_soft_irq,
>> 					IRQF_ONESHOT,
>> diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
>> index 4f35b6a..632db20 100644
>> --- a/include/linux/i2c/tsc2007.h
>> +++ b/include/linux/i2c/tsc2007.h
>> @@ -6,6 +6,14 @@
>> struct tsc2007_platform_data {
>> 	u16	model;				/* 2007. */
>> 	u16	x_plate_ohms;	/* must be non-zero value */
>> +	bool	swap_xy;	/* swap x and y axis */
>> +	bool	invert_x;
>> +	bool	invert_y;
>> +	bool	report_resistance;
>> +	u16	min_x;	/* min and max values reported by ADC */
>> +	u16	min_y;
>> +	u16	max_x;
>> +	u16	max_y;
>> 	u16	max_rt; /* max. resistance above which samples are ignored */
>> 	unsigned long poll_period; /* time (in ms) between samples */
>> 	int	fuzzx; /* fuzz factor for X, Y and pressure axes */
>> -- 
>> 2.5.1
>> 
