From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] Enable backlight when trigger is activated
Date: Wed, 24 Jul 2019 23:16:39 +0200
Message-ID: <f00d99cb-da32-05b3-bf49-447cb8bd33e0@gmail.com>
References: <20190718190849.GA11409@amd>
 <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
 <20190722075032.GA27524@amd> <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
 <20190724083355.GA27716@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724083355.GA27716@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ezequiel Garcia <ezequiel@collabora.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, linux-leds@vger.kernel.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/24/19 10:33 AM, Pavel Machek wrote:
> Hi!
> 
>>>>> +++ b/drivers/leds/trigger/ledtrig-backlight.c
>>>>> @@ -114,6 +114,8 @@ static int bl_trig_activate(struct led_classdev *led)
>>>>>  	n->old_status = UNBLANK;
>>>>>  	n->notifier.notifier_call = fb_notifier_callback;
>>>>>  
>>>>> +	led_set_brightness(led, LED_ON);
>>>>> +
>>>>
>>>> This looks fishy.
>>>>
>>>> Maybe you should use a default-state = "keep" instead? (and you'll have
>>>> to support it in the LED driver).
>>>>
>>>> That'll give you proper "don't touch the LED if it was turned on" behavior,
>>>> which is what you seem to want.
>>>
>>> Actually no, that's not what I want. LED should go on if the display
>>> is active, as soon as trigger is activated.
>>>
>>> Unfortunately, I have see no good way to tell if the display is
>>> active (and display is usually active when trigger is activated).
>>
>> default-state DT property can be also set to "on"
>> (see Documentation/devicetree/bindings/leds/common.txt).
> 
> Yes, except that it does not work with all drivers :-(. In particular,
> it does not work with lm3532.
> 
> We should really move more of the device tree parsing into core, so
> that there's one place to fix...

Right. We could have something similar to led_get_default_pattern().
led_get_default_state() ?

-- 
Best regards,
Jacek Anaszewski
