From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 17:44:42 +0100
Message-ID: <de3b4ae7-6a08-2a03-d80e-059c71c58aed@redhat.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20161110162925.GA28832@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10-11-16 17:29, Pavel Machek wrote:
> Hi!
>
>>>>> Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
>>>>> the sysfs brightness attr for changes.") breaks runtime PM for me.
>>>>>
>>>>> On my omap dm3730 based test system, idle power consumption is over 70
>>>>> times higher now with this patch! It goes from about 6mW for the core
>>>>> system to over 440mW during idle meaning there's some busy timer now
>>>>> active.
>>>>>
>>>>> Reverting this patch fixes the issue. Any ideas?
>
> Are you using any LED that toggles with high frequency? Like perhaps
> LED that is lit when CPU is active?
>
>>> So a user can do "echo 128 > brightness && cat brightness" and
>>> get out 0, or 128, depending purely on timing.
> ...
>>>                Reading from this file while a trigger is active returns
>>> the
>>>                top brightness trigger is going to use.
>
> Yes, that sounds sane.
>
>> It seems that we should get back to your initial approach. i.e. only
>> brightness changes caused by hardware should be reported.
>
> I don't think enabling poll() here is good idea. Some hardware won't
> be able to tell you that it changed the state. Returning maximum
> brightness trigger is going to use seems easier/better.

The idea here is to allow userspace to poll() on the brightness
sysfs atrribute to detect changes autonomously done by the hardware,
such as e.g. happens on both Dell and Thinkpad laptops when pressing
the keyboard backlight cycle hotkey. Note that these keys do not
generate key-press events, the cycling through the brightness levels
(including off) is done entirely in firmware.

But we do get other ACPI events for this which we can use to let
userspace know this happens, which is something which user-
interfaces which allow control over the kbd backlight want to know.

I understand that we will not always be able to do this, here is the
Documentation/ABI/testing/sysfs-class-led text I have in mind:

		The file supports poll() to detect changes, changes are only
		signalled when this file is written or when the hardware /
		firmware changes the brightness itself and the driver can detect
		this. Changes done by kernel triggers / software blinking are
		not signalled.

Note the "and the driver can detect this" language, that has been there
since v1 of the poll() notification patch since I already expected not
all hardware to be able to signal this.

Regards,

Hans
