From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 14:44:10 -0700
Message-ID: <572bcaff-7b17-0614-0cd2-0887ae33eb65@redhat.com>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws> <20170125192711.GB27255@dtor-ws>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125192711.GB27255@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acp>
List-Id: linux-omap@vger.kernel.org

On 01/25/2017 12:27 PM, Dmitry Torokhov wrote:
> On Wed, Jan 25, 2017 at 10:44:32AM -0800, Dmitry Torokhov wrote:
>> On Wed, Jan 25, 2017 at 06:29:55PM +0000, Mark Brown wrote:
>>> On Wed, Jan 25, 2017 at 06:23:20PM +0000, Mark Rutland wrote:
>>>> On Wed, Jan 25, 2017 at 08:56:42AM -0800, Furquan Shaikh wrote:
>>>
>>>>> That is the reason why the recent change to add ACPI support to fixed
>>>>> regulators was done
>>>>> (https://github.com/torvalds/linux/blob/master/drivers/regulator/fixed.c#L100).
>>>
>>>> To be honest, I'm surprised this got merged.
>>>
>>> My understanding was that it was instantiated from another device as an
>>> implementation detail of that device, letting it say "this GPIO should
>>> be handled as a regulator".
>>>
>>>> Mark, this was added in this cycle; can we please rip that out for now?
>>>
>>> If it's instantiated directly we probably should.
>>>
>>>> We can certainly come up with something that allows drivers to support
>>>> both, but trying to do this without updating drivers opens a huge set of
>>>> problems.
>>>
>>> I think there's a reasonable chance that any ACPI specs could be written
>>> in such a way as to allow transparent support in Linux, the main thing
>>> I'd worry about is naming issues.
>>
>> So if I am reading this correctly, currently ACPI does not expose power
>> supplies directly, but rather ties them to the device power state (D0,
>> D3cold, etc). Linux drivers do not usually follow that state model and
>> expect to have all their power supplies be given to them and then
>> figures out what to do with them itself. Given that, what do we do? Do
>> we map only entries from _PR3 so they are available to drivers via
>> regulator_get()? Or we ask the standard to add method enumerating all
>> supplies?
> 
> For the record, the main issue for the drivers, which is being solved by
> exposing power supplies to the driver, is the following:
> 
> 1. We suspend the device. Since there is no regulators the driver
> assumes that it will retain it's state upon resume
> 2. System goes into some sleep state
> 3. System wakes up
> 4. Device goes through resume, normally disabling wakeup interrupt and
> enabling normal processing
> 5. We end up with non functioning device because the firmware actually
> cut the power off without the driver knowing anything about it.
> 
> I would really hate to go through _every_ driver and add the following
> code to the resume path:
> 
> #if IS_ENABLED(CONFIG_ACPI)
> 	if (acpi_device_was_powered_off_between_suspend_and_now(dev)) {
> 		completely_reinitialize_device(dev);
> 	}
> #endif
> 
> Thanks.
> 

Please see Sections 3.2-3.5 (3.6, too, for a broader picture) in the ACPI spec
[0] for an overview of ACPI power management.  Section 7 of the spec [0] adds
the details on how the firmware and OS are to cooperate in managing power.

In those sections, ACPI defines a PowerResource object, aka a power supply of
some flavor.  ACPI devices are then connected to that power resource.  So, the
spec may already have what you need defined.  Further, the code in drivers/acpi
/device_pm.c and drivers/acpi/power.c may handle the situations described -- I
believe that's their intent, at any rate.   If the ACPI ASL is written
properly, I don't think the device driver would have to add the code shown
above; it would just be handled via the acpi driver and ASL.  The ACPI model is
specifically designed so that drivers don't have to know these sorts of things,
so that the hardware and firmware underneath the OS can change over time
without having to change the OS -- the OS just needs to know how to talk to
ACPI.

But, to the point of some of the other discussion on the thread, this ACPI sort
of power management is a very, very different model than DT so that intertwining
the two models is highly unlikely to work, IMHO.



[0] http://www.uefi.org/specifications -- version 6.1, specifically.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
