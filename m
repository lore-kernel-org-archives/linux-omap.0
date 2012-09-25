From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not suspended.
Date: Tue, 25 Sep 2012 15:26:06 +0530
Message-ID: <CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
	<CAKdam572krJZcayRdJ_AciCUZH3LuzD9yoHenhxrB6j9xDZ6JQ@mail.gmail.com>
	<20120925083029.GG31374@n2100.arm.linux.org.uk>
	<20120925083118.GI9137@arwen.pp.htv.fi>
	<20120925091228.GI31374@n2100.arm.linux.org.uk>
	<20120925091112.GK9137@arwen.pp.htv.fi>
	<20120925092118.GJ31374@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120925092118.GJ31374@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 25, 2012 at 2:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 25, 2012 at 12:11:14PM +0300, Felipe Balbi wrote:
>> On Tue, Sep 25, 2012 at 10:12:28AM +0100, Russell King - ARM Linux wrote:
>> > On Tue, Sep 25, 2012 at 11:31:20AM +0300, Felipe Balbi wrote:
>> > > On Tue, Sep 25, 2012 at 09:30:29AM +0100, Russell King - ARM Linux wrote:
>> > > > How is this happening?  I think that needs proper investigation - or if
>> > > > it's had more investigation, then the results needs to be included in
>> > > > the commit description so that everyone can understand the issue here.
>> > > >
>> > > > We should not be resuming a device which hasn't been suspended.  Maybe
>> > > > the runtime PM enable sequence is wrong, and that's what should be fixed
>> > > > instead?
>> > > >
>> > > > This sequence in the probe() function:
>> > > >
>> > > >         pm_runtime_irq_safe(&pdev->dev);
>> > > >         pm_runtime_enable(&pdev->dev);
>> > > >         pm_runtime_get_sync(&pdev->dev);
>> > > >
>> > > > would enable runtime PM while the s/w state indicates that it's disabled,
>> > > > and then that pm_runtime_get_sync() will want to resume the device.  See
>> > > > the section "5. Runtime PM Initialization, Device Probing and Removal"
>> > > > in Documentation/power/runtime_pm.txt, specifically the second paragraph
>> > > > of that section.
>> > >
>> > > that was tested. It worked in pandaboard but didn't work on beagleboard
>> > > XM. Sourav tried to start a discussion about that, but it simply died...
>> > >
>> > > In any case, pm_runtime_get_sync() in probe will always call
>> > > runtime_resume callback, right ?
>> >
>> > Well, if the runtime PM state says it's suspended, and then you enable
>> > runtime PM, the first call to pm_runtime_get_sync() will trigger a resume
>> > attempt.  The patch description is complaining about resume events without
>> > there being a preceding suspend event.
>> >
>> > This could well be why.
>>
>> that's most likely, of course. But should we cause a regression to
>> beagleboard XM because of that ?
>
> What would cause a regression on beagleboard XM?  I have not suggested
> any change other than more investigation of the issue and a fuller patch
> description - yet you're screaming (idiotically IMHO) that mere
> investigation would break beagleboard.
>
> Well, if it's _that_ fragile, that mere investigation of this issue by
> someone elsewhere on the planet would break your beagleboard, maybe it
> deserves to be broken!

The issue was observed at serial init itself in the N800 board and the
log does not
show up much.
http://www.pwsan.com/omap/testlogs/test_tty_next_e36851d0/20120910020323/boot/2420n800/2420n800_log.txt
 What we thought the problem might be with n800 is that it tries to
resume when it didn't suspend before.

There are two ways through which we thought of handling this issue:

a) set device as active before enabling pm (which will prevent

pm_runtime_set_active(dev);
pm_runtime_enable(dev);

OR

b) adding a "suspended" flag to struct omap_uart_port which gets set on
suspend and cleared on resume. Then on resume you can check:

if (!up->suspended)
        return 0;

But using "pm_runtime_set_active" approach breaks things even on
beagle board xm,  though
it works fine on Panda.
Therefore, we used the "suspended" flag approach.

So. I just wanted to get some feedback from community about how using
"pm_runtime_set_active"
behaves differently in omap3 and omap4.
