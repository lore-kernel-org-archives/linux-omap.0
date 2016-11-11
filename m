From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Fri, 11 Nov 2016 09:25:56 +0100
Message-ID: <64de0593-606a-2fff-3726-b0293a624210@redhat.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <de3b4ae7-6a08-2a03-d80e-059c71c58aed@redhat.com>
 <20161110204852.GA31728@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161110204852.GA31728@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10-11-16 21:48, Pavel Machek wrote:
> Hi!
>
>>>> It seems that we should get back to your initial approach. i.e. only
>>>> brightness changes caused by hardware should be reported.
>>>
>>> I don't think enabling poll() here is good idea. Some hardware won't
>>> be able to tell you that it changed the state. Returning maximum
>>> brightness trigger is going to use seems easier/better.
>>
>> The idea here is to allow userspace to poll() on the brightness
>> sysfs atrribute to detect changes autonomously done by the hardware,
>> such as e.g. happens on both Dell and Thinkpad laptops when pressing
>> the keyboard backlight cycle hotkey. Note that these keys do not
>> generate key-press events, the cycling through the brightness levels
>> (including off) is done entirely in firmware.
>
> Ok, so you can do that for keyboard backlight on thinkpad... I guess
> you handle that as a special trigger on the keyboard leds?

No, as said this is all done in firmware, as in this is all dealt
with by (presumably) the acpi-ec (acpi-embedded-controller) the kernel
does not do anything here, the key is "hardwired" to control the
keyboard backlight from the kernels pov.

 > Can other
> triggers, such as heartbeat, be assigned to that "led"?
>
>> But we do get other ACPI events for this which we can use to let
>> userspace know this happens, which is something which user-
>> interfaces which allow control over the kbd backlight want to know.
>
> Yes, you can do that for keyboard backlight... but on thinkpads there
> are more leds, such as battery led. That can blink on battery low, and
> I don't think you can read the current status from hardware.

Well the battery LED does not show up under /sys/class/led so that
is not relevant for this situation, anyways ...

> Getting current state of led blinking with cpu trigger is also not
> quite a good idea.

I agree with you that it would be better if reading the brightness
sysfs attribute would always return the max brightness for LEDs
which are blinking or have a trigger set. But it seems that Jacek
disagrees, I will leave further discussion of this up to you and
Jacek.

> So IMO this should not be done in generic code. Instead,
> kbd-backlight trigger should have special attribute, and that one
> should be pollable.

Again there is no kbd-backlight trigger.

>> I understand that we will not always be able to do this, here is the
>> Documentation/ABI/testing/sysfs-class-led text I have in mind:
>>
>> 		The file supports poll() to detect changes, changes are only
>> 		signalled when this file is written or when the hardware /
>> 		firmware changes the brightness itself and the driver can detect
>> 		this. Changes done by kernel triggers / software blinking are
>> 		not signalled.
>>
>> Note the "and the driver can detect this" language, that has been there
>> since v1 of the poll() notification patch since I already expected not
>> all hardware to be able to signal this.
>
> Lets move it to separate attribute, for triggers that can do that,
> please.

As explained above this has nothing to do with triggers...

Regards,

Hans
