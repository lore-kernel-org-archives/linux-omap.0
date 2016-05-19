From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Thu, 19 May 2016 17:14:15 +0530
Message-ID: <573DA70F.70206@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <573DA29A.1080609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <573DA29A.1080609@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Sylvain Rochet <sylvain.rochet@finsecur.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, Johan Hovold <johan@kernel.org>, Timo Teras <timo.teras@iki.fi>, Masanari Iida <standby24x7@gmail.com>, devicetree@vger.kernel.org, S Twiss <stwiss.opensource@diasemi.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Clifton Barnes <clifton.a.barnes@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-omap@vger.kernel.org, Guido Martinez <guido@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

Hi,

On 05/19/2016 04:55 PM, Krzysztof Kozlowski wrote:
[...]
> On 05/19/2016 11:04 AM, Vignesh R wrote:
>> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
>> index c7fc8d4fb080..8f60289fb6cd 100644
>> --- a/drivers/input/misc/rotary_encoder.c
>> +++ b/drivers/input/misc/rotary_encoder.c
>> @@ -25,24 +25,29 @@
>>  #include <linux/of.h>
>>  #include <linux/pm.h>
>>  #include <linux/property.h>
>> +#include <linux/input-polldev.h>
>>  
>>  #define DRV_NAME "rotary-encoder"
>>  
>>  struct rotary_encoder {
>>  	struct input_dev *input;
>> -
>> +#ifdef CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
> 
> Ifdefs look dirty.

I will drop this.

> 
>> +	struct input_polled_dev *poll_dev;
>> +#endif
>>  	struct mutex access_mutex;
>>  
>>  	u32 steps;
>>  	u32 axis;
>>  	bool relative_axis;
>>  	bool rollover;
>> +	bool absolute_encoder;
>>  
>>  	unsigned int pos;
>>  
>>  	struct gpio_descs *gpios;
>> +	struct device *dev;
>>  
>> -	unsigned int *irq;
>> +	int *irq;
>>  
>>  	bool armed;
>>  	signed char dir;	/* 1 - clockwise, -1 - CCW */
>> @@ -67,6 +72,21 @@ static unsigned int rotary_encoder_get_state(struct rotary_encoder *encoder)
>>  	return ret & 3;
>>  }
>>  
>> +static unsigned int rotary_encoder_get_gpios_state(struct rotary_encoder
>> +						   *encoder)
>> +{
>> +	int i;
>> +	unsigned int ret = 0;
>> +
>> +	for (i = 0; i < encoder->gpios->ndescs; ++i) {
>> +		int val = gpiod_get_value_cansleep(encoder->gpios->desc[i]);
>> +
>> +		ret = ret << 1 | val;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static void rotary_encoder_report_event(struct rotary_encoder *encoder)
>>  {
>>  	if (encoder->relative_axis) {
>> @@ -178,6 +198,72 @@ out:
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void rotary_encoder_setup_input_params(struct rotary_encoder  *encoder)
>> +{
>> +	struct input_dev *input = encoder->input;
>> +	struct platform_device *pdev = to_platform_device(encoder->dev);
>> +
>> +	input->name = pdev->name;
>> +	input->id.bustype = BUS_HOST;
>> +	input->dev.parent = encoder->dev;
>> +
>> +	if (encoder->relative_axis)
>> +		input_set_capability(input, EV_REL, encoder->axis);
>> +	else
>> +		input_set_abs_params(input,
>> +				     encoder->axis, 0, encoder->steps, 0, 1);
>> +}
>> +
>> +static irqreturn_t rotary_absolute_encoder_irq(int irq, void *dev_id)
>> +{
>> +	struct rotary_encoder *encoder = dev_id;
>> +	unsigned int state;
>> +
>> +	mutex_lock(&encoder->access_mutex);
>> +
>> +	state = rotary_encoder_get_gpios_state(encoder);
>> +	if (state != encoder->last_stable) {
>> +		input_report_abs(encoder->input, encoder->axis, state);
>> +		input_sync(encoder->input);
>> +		encoder->last_stable = state;
>> +	}
>> +
>> +	mutex_lock(&encoder->access_mutex);
> 
> 1. Double mutex_lock()? Oh, that is weird. Please document it at least
> in form of lockdep annotations.
> 
> 2. Maybe that should be unlock? Did you test this code?
> 

Sorry... this should have been unlock.
I dont have a h/w with rotary-encoder hooked to IRQ line. It would be
much appreciated if someone with rotary-encoder hooked up to h/w IRQ
line test this patch.

>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +#ifdef CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
> 
> Same here and later in the code, ifdefs look dirty.

Ok, I will remove #ifdefs and directly select INPUT_POLLDEV when
INPUT_GPIO_ROTARY_ENCODER is selected.

-- 
Regards
Vignesh
