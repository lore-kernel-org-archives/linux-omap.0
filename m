From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 09:49:08 +0100
Message-ID: <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 09-11-16 21:45, Jacek Anaszewski wrote:
> Hi Tony,
>
> On 11/09/2016 08:23 PM, Tony Lindgren wrote:
>> Hi,
>>
>> Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
>> the sysfs brightness attr for changes.") breaks runtime PM for me.
>>
>> On my omap dm3730 based test system, idle power consumption is over 70
>> times higher now with this patch! It goes from about 6mW for the core
>> system to over 440mW during idle meaning there's some busy timer now
>> active.
>>
>> Reverting this patch fixes the issue. Any ideas?
>
> Thanks for the report. This is probably caused by sysfs_notify_dirent().
> I'm afraid that we can't keep this feature in the current shape.
> Hans, I'm dropping the patch. We probably will have to delegate this
> call to a workqueue task. Think about use cases when the LED is blinked
> with high frequency e.g. from ledtrig-disk.c.

sysfs_notify_dirent() already uses a workqueue, here is the actual
implementation of it (from fs/kernfs/file.c) :

void kernfs_notify(struct kernfs_node *kn)
{
         static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
         unsigned long flags;

         if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
                 return;

         spin_lock_irqsave(&kernfs_notify_lock, flags);
         if (!kn->attr.notify_next) {
                 kernfs_get(kn);
                 kn->attr.notify_next = kernfs_notify_list;
                 kernfs_notify_list = kn;
                 schedule_work(&kernfs_notify_work);
         }
         spin_unlock_irqrestore(&kernfs_notify_lock, flags);
}

So using a workqueue is not going to help. Note that I already
feared this, which is why my initial implementation only called
sysfs_notify_dirent() for user initiated changes and not for
triggers / blinking.

I think we may need to reconsider what getting the brightness
sysfs atrribute actually returns. Currently when a LED is
blinking it will return 0 resp. the actual brightness depending
on when in the blink cycle the user reads the brightness
sysfs atrribute.

So a user can do "echo 128 > brightness && cat brightness" and
get out 0, or 128, depending purely on timing.

This seems to contradict what Documentation/ABI/testing/sysfs-class-led
has to say:

What:           /sys/class/leds/<led>/brightness
Date:           March 2006
KernelVersion:  2.6.17
Contact:        Richard Purdie <rpurdie@rpsys.net>
Description:
                 Set the brightness of the LED. Most LEDs don't
                 have hardware brightness support, so will just be turned on for
                 non-zero brightness settings. The value is between 0 and
                 /sys/class/leds/<led>/max_brightness.

                 Writing 0 to this file clears active trigger.

                 Writing non-zero to this file while trigger is active changes the
                 top brightness trigger is going to use.

Even though it only talks about writing, the logical thing would be for
reading to be the exact opposite of writing, so we would get:

                 Reading from this file while a trigger is active returns the
                 top brightness trigger is going to use.

The current docs say not about (sw) blinking, but that should be treated just
like a trigger IMHO.

If we can get consensus on what the read behavior for the brightness attribute
should be, then I think that a better poll() behavior will automatically follow
from that.

Regards,

Hans
