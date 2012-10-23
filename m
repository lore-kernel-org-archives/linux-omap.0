From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 23 Oct 2012 11:18:12 +0200
Message-ID: <508660D4.9030507@ti.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121022155028.GA13791-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Dimitry,

On 10/22/2012 05:50 PM, Dmitry Torokhov wrote:
> Hi Sourav,
> 
> On Mon, Oct 22, 2012 at 06:43:00PM +0530, Sourav Poddar wrote:
>> Adapt keypad to use pinctrl framework.
>>
>> Tested on omap4430 sdp with 3.7-rc1 kernel.
> 
> I do not see anything in the driver that would directly use pinctrl. Is
> there a better place to select default pin configuration; maybe when
> instantiating platform device?

Why?
The devm_pinctrl_get_select_default is using the pinctrl.
That's why it is named "get_select_default" and not "get" only.
This API ensure that the pin will be set to the default state, and this
is all we need to do during the probe.

There is no point to change the mux if the driver is not probed, because
potentially the pin can be use be another driver.
So probe is the right place to do that for my point of view. Moreover
with DT we don't have that board static config like we had before to do
that kind of pin mux init.

But, maybe I'm missing your point.

Regards,
Benoit


> 
> Thanks.
> 
>>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
>> ---
>> v1->v2
>> - Added "PROBE_DEFER" check 
>>  drivers/input/keyboard/omap4-keypad.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
>> index c05f98c..502b832 100644
>> --- a/drivers/input/keyboard/omap4-keypad.c
>> +++ b/drivers/input/keyboard/omap4-keypad.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/input.h>
>>  #include <linux/slab.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pinctrl/consumer.h>
>>  
>>  #include <linux/platform_data/omap4-keypad.h>
>>  
>> @@ -76,6 +77,7 @@ enum {
>>  
>>  struct omap4_keypad {
>>  	struct input_dev *input;
>> +	struct pinctrl	*pins;
>>  
>>  	void __iomem *base;
>>  	unsigned int irq;
>> @@ -298,6 +300,15 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>>  		goto err_release_mem;
>>  	}
>>  
>> +	keypad_data->pins = devm_pinctrl_get_select_default(&pdev->dev);
>> +	if (IS_ERR(keypad_data->pins)) {
>> +		if (PTR_ERR(keypad_data->pins) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +
>> +		dev_warn(&pdev->dev, "did not get pins for keypad error: %li\n",
>> +					PTR_ERR(keypad_data->pins));
>> +		keypad_data->pins = NULL;
>> +	}
>>  
>>  	/*
>>  	 * Enable clocks for the keypad module so that we can read
>> -- 
>> 1.7.1
>>
> 
