From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 1/1] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Mon, 16 Mar 2015 15:11:17 +0200
Message-ID: <5506D675.8010006@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>	 <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com>	 <54CF4FC7.2050309@ti.com> <1426509149.2330.5.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426509149.2330.5.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ivan,

On 16/03/15 14:32, Ivan T. Ivanov wrote:
> Hi, 
> 
> On Mon, 2015-02-02 at 12:21 +0200, Roger Quadros wrote:
>> This driver observes the USB ID pin connected over a GPIO and
>> updates the USB cable extcon states accordingly.
>>
>> The existing GPIO extcon driver is not suitable for this purpose
>> as it needs to be taught to understand USB cable states and it
>> can't handle more than one cable per instance.
>>
>> For the USB case we need to handle 2 cable states.
>> 1) USB (attach/detach)
>> 2) USB-HOST (attach/detach)
>>
>> This driver can be easily updated in the future to handle VBUS
>> events in case it happens to be available on GPIO for any platform.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>> v4:
>> - got rid of id_irqwake flag. Fail if enable/disable_irq_wake() fails
>> - changed host cable name to "USB-HOST"
> 
> I am sorry that I am getting a bit little late into this.
> 
> Isn't supposed that we have to use strings defined in 
> const char extcon_cable_name[][]?
> 
> 
>> +
>> +/* List of detectable cables */
>> +enum {
>> +       EXTCON_CABLE_USB = 0,
>> +       EXTCON_CABLE_USB_HOST,
>> +
> 
> Same here: duplicated with enum extcon_cable_name
> 
>> +       EXTCON_CABLE_END,
>> +};
>> +
>> +static const char *usb_extcon_cable[] = {
>> +       [EXTCON_CABLE_USB] = "USB",
>> +       [EXTCON_CABLE_USB_HOST] = "USB-HOST",
>> +       NULL,
>> +};

I'm not exactly sure how else it is supposed to work if we
support only a subset of cables from the global extcon_cable_name[][].

>>
> 
> <snip>
> 
>> +
>> +static int usb_extcon_probe(struct platform_device *pdev)
>> +{
>>
> 
> <snip>
> 
>> +
>> +       ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
>> +                                       usb_irq_handler,
>> +                                       IRQF_TRIGGER_RISING |
>> +                                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> 
> Shouldn't triggers be defined in DTS files?

Could be but we're sure that we always need the trigger for both rising/falling edges
in this case. So the usage is more appropriately decided from application point of view
rather than h/w point of view. h/w is generic GPIO.

cheers,
-roger
