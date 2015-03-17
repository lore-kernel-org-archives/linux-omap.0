From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 1/1] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Tue, 17 Mar 2015 11:01:51 +0900
Message-ID: <55078B0F.1040800@samsung.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
 <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com>
 <54CF4FC7.2050309@ti.com> <1426509149.2330.5.camel@linaro.org>
 <5506D675.8010006@ti.com> <1426515811.2330.16.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426515811.2330.16.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ivan,

On 03/16/2015 11:23 PM, Ivan T. Ivanov wrote:
> 
> Hi Roger, 
> 
> On Mon, 2015-03-16 at 15:11 +0200, Roger Quadros wrote:
>> Hi Ivan,
>>
>> On 16/03/15 14:32, Ivan T. Ivanov wrote:
>>> Hi,
>>>
>>> On Mon, 2015-02-02 at 12:21 +0200, Roger Quadros wrote:
>>>> This driver observes the USB ID pin connected over a GPIO and
>>>> updates the USB cable extcon states accordingly.
>>>>
>>>> The existing GPIO extcon driver is not suitable for this purpose
>>>> as it needs to be taught to understand USB cable states and it
>>>> can't handle more than one cable per instance.
>>>>
>>>> For the USB case we need to handle 2 cable states.
>>>> 1) USB (attach/detach)
>>>> 2) USB-HOST (attach/detach)
>>>>
>>>> This driver can be easily updated in the future to handle VBUS
>>>> events in case it happens to be available on GPIO for any platform.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>> v4:
>>>> - got rid of id_irqwake flag. Fail if enable/disable_irq_wake() fails
>>>> - changed host cable name to "USB-HOST"
>>>
>>> I am sorry that I am getting a bit little late into this.
>>>
>>> Isn't supposed that we have to use strings defined in
>>> const char extcon_cable_name[][]?
>>>
>>>
>>>> +
>>>> +/* List of detectable cables */
>>>> +enum {
>>>> +       EXTCON_CABLE_USB = 0,
>>>> +       EXTCON_CABLE_USB_HOST,
>>>> +
>>>
>>> Same here: duplicated with enum extcon_cable_name
>>>
>>>> +       EXTCON_CABLE_END,
>>>> +};
>>>> +
>>>> +static const char *usb_extcon_cable[] = {
>>>> +       [EXTCON_CABLE_USB] = "USB",
>>>> +       [EXTCON_CABLE_USB_HOST] = "USB-HOST",
>>>> +       NULL,
>>>> +};
>>
>> I'm not exactly sure how else it is supposed to work if we
>> support only a subset of cables from the global extcon_cable_name[][].
> 
> I don't see issue that we use just 2 events. I think that we can
> reuse  enum extcon_cable_name and strings already defined in 
> extcon_cable_name[][] global variable. It is defined extern in
> extcon.h file exactly for this purpose, no?

'extcon_cable_name' global variable is not used on extcon driver directly.
It is just recommended cable name. 

I have plan to use standard cable name for extcon driver instead of that
each extcon driver define the cable name.

[snip]

Thanks,
Chanwoo Choi
