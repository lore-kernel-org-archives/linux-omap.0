From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
Date: Sat, 14 Jan 2012 01:06:41 +0530
Message-ID: <4F1087C9.6030908@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<4EEFC23A.30201@gmail.com>	<20111219233559.GW6464@atomide.com>	<4EF0671B.7090508@ti.com>	<4EF0824A.9060208@ti.com>	<4EF096C9.1070808@ti.com>	<4F09D10B.7010807@ti.com> <CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:47651 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758862Ab2AMTgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 14:36:50 -0500
Received: by yhoo21 with SMTP id o21so480136yho.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:36:49 -0800 (PST)
In-Reply-To: <CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Mike Turquette <mturquette@ti.com>

Hi Olof,

On Monday 09 January 2012 11:12 AM, Olof Johansson wrote:
> Hi,
>
> On Sun, Jan 8, 2012 at 9:23 AM, Aneesh V<aneesh@ti.com>  wrote:
>> Hi,
>>
>>
>> On Tuesday 20 December 2011 03:08 PM, Aneesh V wrote:
>>>
>>> Hi Benoit
>>>
>>> On Tuesday 20 December 2011 06:10 PM, Cousson, Benoit wrote:
>>>>
>>>> Hi Aneesh,
>>>>
>>>
>>> <snip>
>>>
>>>>>>> In general, is it really feasible to parse the DTB before DDR is
>>>>>>> initialized?
>>>>>>
>>>>>>
>>>>>> Changing timings is still needed for DVFS during runtime.
>>>>>>
>>>>>> But we can boot to userspace with bootloader set timings, so I'm
>>>>>
>>>>>
>>>>> As far as I understand, in the current out-of-tree DVFS implementation
>>>>> for OMAP, DVFS can start even before user-space.
>>>>
>>>>
>>>> Maybe it is the case, but that does not mean it should.
>>>> We can potentially delay the DVFS init until the user-space is started.
>>>> This should not be considered as a big constraint.
>
> Or at least until ramdisk is available, and store the tables there.
> It's a matter of seconds, delaying DVFS initialization until then
> shouldn't be the end of the world.

It's not about power savings, here is what I understand from
discussion with power management folks. In our current architecture
drivers can set frequency constraints with clock framework and this may
in turn initiate frequency scaling and this can happen before user
space. Perhaps we could forbid this too. But I am not sure if the
benefit is worth the trouble.

>
>>>>
>>>>>> thinking that maybe these timings should be just set by loadable
>>>>>> modules. Just the configuration of which timings to select should
>>>>>> be passed via DT. Something in compatible like:
>>>>>>
>>>>>> .compatible = "ti,omap3630", "sdram-micron-mt46h32m32lf-6";
>>>>>>
>>>>>> And that should allow the SDRC driver to only accept timings for
>>>>>> "sdram-micron-mt46h32m32lf-6".
>>>>>
>>>>>
>>>>> Do you mean one module per memory device and have all timing data in
>>>>> the respective module? Wouldn't this clutter the kernel proper with all
>>>>> these tables. By having the timing data in DT, it can be eventually
>>>>> moved out of kernel eventually, right?
>>>>
>>>>
>>>> Yes, that's the theory, but referring to Olof's point, this is not
>>>> necessarily the goal of DT to store all the information that are not
>>>> board dependent.
>>>> In this case, each DDR will have it sets of well known AC timings data
>>>> that will never depend of the board config. In this case, storing that
>>>> inside DT might not be the best solution.
>>>>
>>>> In fact we always had the same kind of discussion for the pinmux data
>>>> and for the clock data...
>>>>
>>>> The conclusion being that most of the static data does not have to be in
>>>> the DTS.
>>>> But since Linus was complaining about the huge amount of data inside the
>>>> kernel, it is not obvious what the best solution is:-)
>>>
>>>
>>> Hmm.. I get the point now. Linus' complaint is what I had in mind too.
>>> My humble opinion is to have such data in DTS but re-use it as much as
>>> possible. That is, we could have something like a "sdram-micron-
>>> mt46h32m32lf-6.dtsi"(as you suggested before) that can be included by
>>> board level DTS files. I think the fact that dts files are organized at
>>> arch level today is limiting such re-use. Please correct me if I am
>>> wrong.
>>
>>
>> Gentle reminder on this one. Are we aligned on having the DDR timings
>> in device tree?
>
> I didn't revisit the thread until today, unfortunately, but the
> approach suggested by Tony sounds quite intriguing: Only encode the
> memory chip id, and have the driver request firmware (not a module)
> for that model that contains the SPD (if it isn't provided by the
> memory module itself, which it rarely is on embedded platforms). That
> data can then be parsed by the kernel like regular SPD.
>
> As a second-best option, encoding in SPD format in the device-tree
> through dtsi files sounds like a reasonable approach: the format is
> already standardized and drivers who can already deal with i2c-based
> SPD data can just use it (with some minor changes).

I did look for an SPD spec for LPDDR2, but couldn't find one. It
appears to me that SPD is not used in LPDDR2 devices and therefore
there is no standard governing it. I checked the DDR3 spec too. But
that doesn't seem to have some parameters needed by our controller.

Even if SPD worked, I wonder if that is the right solution for our
need. Don't you think it will be too cryptic for the user to input and
verify the data (some of the bytes in the layout are a combination of
more than one parameter). It's all fine if it came from the memory
device. But when we have to enter it manually, can't we chose a more
readable representation?

We wish to drop the DDR3 support because we have concluded that our
platforms with DDR3 memories will not scale DDR frequency due to
limitations in DDR3 protocol(operating frequency can vary only in a
small range). So, is it ok to persist with my bindings for LPDDR2
(fixing the comments already given by you) and drop the DDR3 part
from it?

br,
Aneesh
