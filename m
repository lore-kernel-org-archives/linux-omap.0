From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
Date: Tue, 20 Dec 2011 13:40:42 +0100
Message-ID: <4EF0824A.9060208@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com> <4EEFC23A.30201@gmail.com> <20111219233559.GW6464@atomide.com> <4EF0671B.7090508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab1LTMk4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 07:40:56 -0500
In-Reply-To: <4EF0671B.7090508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Aneesh,

On 12/20/2011 11:44 AM, Aneesh V wrote:
> On Tuesday 20 December 2011 05:05 AM, Tony Lindgren wrote:
>> * Rob Herring<robherring2@gmail.com> [111219 14:29]:
>>> On 12/19/2011 08:05 AM, Aneesh V wrote:
>>>> This is an RFC to add new device tree bindings for DDR memories and
>>>> EMIF - TI's DDR SDRAM controller.
>>>>
>>>> The first patch adds bindings for DDR memories. Currently,
>>>> we have added properties for only DDR3 and LPDDR2 memories.
>>>> However, the binding can be easily extended to describe
>>>> other types such as DDR2 in the future.
>>>>
>>>> The second patch provides the bindings for the EMIF controller.
>>>>
>>>> The final patch provides DT data for EMIF controller instances
>>>> in OMAP4 and LPDDR2 memories attached to them on various boards.
>>>>
>>>> Thanks to Rajendra for answering my numerous queries on device tree.
>>>>
>>>> This is a re-post of the RFC that was posted to devicetree-discuss ml,
>>>> now sent to a larger audience and looping out an internal list.
>>>> Please ignore the previous version.
>>>
>>> There's already a standard way (i.e. JEDEC standard) to define DDR chip
>>> configuration that's called SPD. Why invent something new? While this is
>>> normally an i2c eeprom on a DIMM, there's no reason you couldn't get it
>>> from somewhere else including perhaps the DT. There's already code in
>>> u-boot that can parse SPD data.
>>
>> I agree generic JEDEC standard would be good for the DT.
>
> Please see my comments in reply to Rob's mail. SPD doesn't seems to
> have a standard for LPDDR2. What JEDEC has now is not suitable for our
> needs.
>
>>
>>> In general, is it really feasible to parse the DTB before DDR is
>>> initialized?
>>
>> Changing timings is still needed for DVFS during runtime.
>>
>> But we can boot to userspace with bootloader set timings, so I'm
>
> As far as I understand, in the current out-of-tree DVFS implementation
> for OMAP, DVFS can start even before user-space.

Maybe it is the case, but that does not mean it should.
We can potentially delay the DVFS init until the user-space is started.
This should not be considered as a big constraint.

>> thinking that maybe these timings should be just set by loadable
>> modules. Just the configuration of which timings to select should
>> be passed via DT. Something in compatible like:
>>
>> .compatible = "ti,omap3630", "sdram-micron-mt46h32m32lf-6";
>>
>> And that should allow the SDRC driver to only accept timings for
>> "sdram-micron-mt46h32m32lf-6".
>
> Do you mean one module per memory device and have all timing data in
> the respective module? Wouldn't this clutter the kernel proper with all
> these tables. By having the timing data in DT, it can be eventually
> moved out of kernel eventually, right?

Yes, that's the theory, but referring to Olof's point, this is not 
necessarily the goal of DT to store all the information that are not 
board dependent.
In this case, each DDR will have it sets of well known AC timings data 
that will never depend of the board config. In this case, storing that 
inside DT might not be the best solution.

In fact we always had the same kind of discussion for the pinmux data 
and for the clock data...

The conclusion being that most of the static data does not have to be in 
the DTS.
But since Linus was complaining about the huge amount of data inside the 
kernel, it is not obvious what the best solution is:-)

Regards,
Benoit
