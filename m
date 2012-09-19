From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] serial: omap: Remove unnecessary checks from suspend/resume
Date: Wed, 19 Sep 2012 14:43:17 -0700
Message-ID: <87r4pxelje.fsf@deeprootsystems.com>
References: <1347968154-27997-1-git-send-email-sourav.poddar@ti.com>
	<20120918113444.GG24047@arwen.pp.htv.fi>
	<CAKdam56UKpc3icL7J7+Om=5Qk_P4ckWM+XY5E+GFvXieAAxjyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAKdam56UKpc3icL7J7+Om=5Qk_P4ckWM+XY5E+GFvXieAAxjyA@mail.gmail.com>
	(Sourav Poddar's message of "Tue, 18 Sep 2012 17:14:15 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
List-Id: linux-omap@vger.kernel.org

"Poddar, Sourav" <sourav.poddar@ti.com> writes:

> Hi Felipe,
>
> On Tue, Sep 18, 2012 at 5:04 PM, Felipe Balbi <balbi@ti.com> wrote:
>> On Tue, Sep 18, 2012 at 05:05:54PM +0530, Sourav Poddar wrote:
>>> Drop the check for "up" being valid on suspend/resume callbacks.
>>> It should be valid always. Get rid of the "pdata" check also as
>>> serial_omap_get_context_loss_count() checks for it.
>>>
>>> Tested on omap4 panda and 3630 based Beagle board.
>>
>> you need a blank line here. Other than that:
>>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>>
>> ps: what kind of tests did you run, btw ?
>>
> Boot tested on Panda.
> Boot and PM tested(hitiing Off) on Beagle.

What does "PM tested" mean.  hitting off in idle?  hitting off in
suspend?  both?

Please clarify.

Thanks,

Kevin
