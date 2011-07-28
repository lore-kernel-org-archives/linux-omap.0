From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 28 Jul 2011 20:20:45 +0200
Message-ID: <4E31A87D.5070704@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-4-git-send-email-manjugk@ti.com> <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com> <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com> <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com> <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com> <20110718090710.GZ5783@atomide.com> <20110719213458.GO6848@ponder.secretlab.ca> <4E27E967.7090501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60269 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab1G1SVG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 14:21:06 -0400
In-Reply-To: <4E27E967.7090501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Hi Rajendra,

On 7/21/2011 10:55 AM, Nayak, Rajendra wrote:
> On 7/20/2011 3:04 AM, Grant Likely wrote:
>> On Mon, Jul 18, 2011 at 02:07:10AM -0700, Tony Lindgren wrote:
>>> * Grant Likely<grant.likely@secretlab.ca>   [110716 22:08]:
>>>>
>>>> The way I see it, you've got two options:
>>>>
>>>> 1) modify the of_platform_bus_create() to call some kind of
>>>> of_platform_bus_create_omap() for devices that match "ti,omap3-device"
>>>> or something.
>>>>
>>>> 2) Leave of_platform_bus_create(), and instead us a notifier to attach
>>>> hwmod data to normal platform devices.  omap_device_build() is
>>>> actually pretty simple.  It allocated a device, it attaches
>>>> platform_data and hwmod pointers to the device and registers it.
>>>> omap_device_register() is just a wrapper around
>>>> platform_device_register().
>>>>
>>>> My preference is definitely #2, but there is a wrinkle in this
>>>> approach.  Unfortunately omap_devices are not simply plain
>>>> platform_devices with extra data attached, an omap_device actually
>>>> embeds the platform_device inside it, which cannot be attached after
>>>> the fact.  I think I had talked with Kevin (cc'd) about eliminating
>>>> the embedding, but I cannot remember clearly on this point.  As long
>>>> as platform_device remains embedded inside struct omap_device, #2
>>>> won't work.
>>>>
>>>> In either case, looking up the correct hwmod data should be easy for
>>>> any device provided the omap code maintains a lookup table of
>>>> compatible strings and base addresses of devices (much like auxdata).
>>>> In fact, I'd be okay with extending auxdata to include OMAP fields if
>>>> that would be easiest since the whole point of auxdata is to ease the
>>>> transition to DT support.  When a matching device is created, the
>>>> hwmod pointer can easily be attached.  This should work transparently
>>>> for all omap devices, not just the i2c bus.
>>>
>>> Well we should be able to automgagically build the omap_device for
>>> each device tree entry.
>>>
>>> And then the device driver probe and runtime PM should be able to take
>>> care of the rest for the driver. And then there's no more driver
>>> specific platform init code needed ;)
>>
>> Right!  That's the solution I'd like to see.
>>
>>> How about if we just have the hwmod code call omap_device_build for
>>> each device tree entry?
>>
>> I think that is pretty much equivalent to suggestion #1 above, only
>> I'm suggesting to take advantage of the infrastructure already
>> available in driver/of/platform.c in the form of
>> of_platform_populate().  The "of_platform_bus_create_omap()" function
>> suggested above I assumed would directly call omap_device_build().
>
> In fact a lot of what omap_device_build() does today might not even be
> needed anymore. A lot of what it does is populate the platform_device
> structure by looking up the hwmod structs.
> Most of that information would now come from DT and hence all of that
> can be taken off from the hwmod structs. What will still be needed in
> hwmod is other data needed to runtime enable/idle the devices. That
> data however still needs to be linked with the platform_device's that
> DT would create which is what I guess could be done in something
> like a of_platform_bus_create_omap().
>
> Paul/Benoit, do you guys agree we can get rid of some of the data
> from hwmod, whatever would now get passed in from DT, and keep
> only the PRCM/OCP related stuff for runtime handling?

We need to discuss that further, but last time we discussed with Paul 
and Tony, we were considering starting with a DT that will just contain 
the list of devices and a reference to one of several hwmod name.

That will allow us to get rid of all the crappy devices init code we 
have here and there in OMAP today.
That phase can already keep us busy for some time :-)

The DT format has some limitation today to describe a device that is 
connected to several buses and thus have several addresses.
The DT format is providing only the CPU view of the system, meaning that 
we cannot take advantage of it to give the memory map of the DSP, or the 
CortexM3 inside OMAP4 for example. OK, I know, hwmod is not providing 
that information either today... but that was the plan:-)

Because of that we will miss a lot of data we are retrieving today from 
hwmod. So for sure, we can define any kind of data in DT, but it will be 
much better to support that kind of details in the format directly 
instead of adding some custom TI nodes.

For my point of view, the DT format should evolve toward a full 
hierarchical HW representation from the board level instead of a CPU 
centric one. But that just my .2 cents.

Meanwhile, maybe we can start moving basic data from hwmod to DT.
At first we should probably just do the device -> hwmod binding using DT.

There is so much stuff to do, that the hardest part is to figure out 
where to start:-)

Regards,
Benoit
