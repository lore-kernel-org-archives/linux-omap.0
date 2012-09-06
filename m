From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP GPIO - don't wake from suspend unless requested.
Date: Thu, 6 Sep 2012 12:57:46 +0530
Message-ID: <CAMQu2gyKJhhPnmx4pwLptV3FGw_ZssyB_eXDS6upB6ncwxG2cg@mail.gmail.com>
References: <20120825214459.7333a376@notabene.brown> <CAMQu2gz0-U4GxEpZFfmJec+0FRs7ugy8EYS3HyYhb1jwbMBjug@mail.gmail.com>
 <20120827085312.75957354@notabene.brown> <CAMQu2gwH0O+NHV7H2aF375qmv0=TKb6RweOLohTHtB4UhQ-1gQ@mail.gmail.com>
 <CAMQu2gw2b8HHDPuSRuHXVYn3sJ5BYi_PuOT=snpa3zD5ert=QQ@mail.gmail.com>
 <20120906130510.32b0b877@notabene.brown> <CAMQu2gxGNJ+NW_rcRiXNE=OMTq8Hb81_1hDZnNen6mjc2cf6BQ@mail.gmail.com>
 <20120906170245.10e97bdd@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120906170245.10e97bdd@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 6, 2012 at 12:32 PM, NeilBrown <neilb@suse.de> wrote:
> On Thu, 6 Sep 2012 11:18:09 +0530 "Shilimkar, Santosh"
> <santosh.shilimkar@ti.com> wrote:
>
>> On Thu, Sep 6, 2012 at 8:35 AM, NeilBrown <neilb@suse.de> wrote:
>> > On Mon, 3 Sep 2012 22:59:06 -0700 "Shilimkar, Santosh"
>> > <santosh.shilimkar@ti.com> wrote:
>
>> >> After thinking bit more on this, the problem seems to be coming
>> >> mainly because the gpio device is runtime suspended bit early than
>> >> it should be. Similar issue seen with i2c driver as well. The i2c issue
>> >> was discussed with Rafael at LPC last week. The idea is to move
>> >> the pm_runtime_enable/disable() calls entirely up to the
>> >> _late/_early stage of device suspend/resume.
>> >> Will update this thread once I have further update.
>> >
>> > This won't be late enough.  IRQCHIP_MASK_ON_SUSPEND takes effect after all
>> > the _late callbacks have been called.
>> > I, too, spoke to Rafael about this in San Diego.  He seemed to agree with me
>> > that the interrupt needs to be masked in the ->suspend callback.  any later
>> > is too late.
>> >
>> Thanks for information about your discussion. Will wait for the patch then.
>>
>> Regards
>> santosh
>
> I already sent a patch - that is what started this thread :-)
>
> I include it below.
> You said "The patch doesn't seems to be correct" but didn't expand on why.
> Do you still think it is not correct?  I wouldn't be surprised if there is
> some case that it doesn't handle quite right, but it seems right to me.
>
Sorry I though you were talking about moving the "Checking wakeup interrupts"
bit early as discussed on the follow up of alternate suggested patch to make
use of  IRQCHIP_MASK_ON_SUSPEND.

I think we need to fix the issue seen with ' IRQCHIP_MASK_ON_SUSPEND'
patch. That is at least the expected way to manage suspend and wakeup
irq masks for a IRQCHIP.

Regards
Santosh
