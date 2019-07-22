From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] Enable backlight when trigger is activated
Date: Mon, 22 Jul 2019 22:25:05 +0200
Message-ID: <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
References: <20190718190849.GA11409@amd>
 <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
 <20190722075032.GA27524@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722075032.GA27524@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ezequiel Garcia <ezequiel@collabora.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, linux-leds@vger.kernel.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On 7/22/19 9:50 AM, Pavel Machek wrote:
> Hi!
> 
>>> Configuring backlight trigger from dts results in backlight off during
>>> boot. Machine looks dead upon boot, which is not good.
>>>
>>> Fix that by enabling LED on trigger activation.
> 
>>> +++ b/drivers/leds/trigger/ledtrig-backlight.c
>>> @@ -114,6 +114,8 @@ static int bl_trig_activate(struct led_classdev *led)
>>>  	n->old_status = UNBLANK;
>>>  	n->notifier.notifier_call = fb_notifier_callback;
>>>  
>>> +	led_set_brightness(led, LED_ON);
>>> +
>>
>> This looks fishy.
>>
>> Maybe you should use a default-state = "keep" instead? (and you'll have
>> to support it in the LED driver).
>>
>> That'll give you proper "don't touch the LED if it was turned on" behavior,
>> which is what you seem to want.
> 
> Actually no, that's not what I want. LED should go on if the display
> is active, as soon as trigger is activated.
> 
> Unfortunately, I have see no good way to tell if the display is
> active (and display is usually active when trigger is activated).

default-state DT property can be also set to "on"
(see Documentation/devicetree/bindings/leds/common.txt).

You could make use of LED_INIT_DEFAULT_TRIGGER flag and
parse DT property in the activate op. Similar approach has been
applied e.g. in ledtrig-pattern.c.

-- 
Best regards,
Jacek Anaszewski
