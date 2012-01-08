From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
Date: Sun, 08 Jan 2012 18:23:23 +0100
Message-ID: <4F09D10B.7010807@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com> <4EEFC23A.30201@gmail.com> <20111219233559.GW6464@atomide.com> <4EF0671B.7090508@ti.com> <4EF0824A.9060208@ti.com> <4EF096C9.1070808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55533 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753417Ab2AHRX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 12:23:29 -0500
Received: by ggdk6 with SMTP id k6so1527535ggd.33
        for <linux-omap@vger.kernel.org>; Sun, 08 Jan 2012 09:23:27 -0800 (PST)
In-Reply-To: <4EF096C9.1070808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

Hi,

On Tuesday 20 December 2011 03:08 PM, Aneesh V wrote:
> Hi Benoit
>
> On Tuesday 20 December 2011 06:10 PM, Cousson, Benoit wrote:
>> Hi Aneesh,
>>
>
> <snip>
>
>>>>> In general, is it really feasible to parse the DTB before DDR is
>>>>> initialized?
>>>>
>>>> Changing timings is still needed for DVFS during runtime.
>>>>
>>>> But we can boot to userspace with bootloader set timings, so I'm
>>>
>>> As far as I understand, in the current out-of-tree DVFS implementation
>>> for OMAP, DVFS can start even before user-space.
>>
>> Maybe it is the case, but that does not mean it should.
>> We can potentially delay the DVFS init until the user-space is started.
>> This should not be considered as a big constraint.
>>
>>>> thinking that maybe these timings should be just set by loadable
>>>> modules. Just the configuration of which timings to select should
>>>> be passed via DT. Something in compatible like:
>>>>
>>>> .compatible = "ti,omap3630", "sdram-micron-mt46h32m32lf-6";
>>>>
>>>> And that should allow the SDRC driver to only accept timings for
>>>> "sdram-micron-mt46h32m32lf-6".
>>>
>>> Do you mean one module per memory device and have all timing data in
>>> the respective module? Wouldn't this clutter the kernel proper with all
>>> these tables. By having the timing data in DT, it can be eventually
>>> moved out of kernel eventually, right?
>>
>> Yes, that's the theory, but referring to Olof's point, this is not
>> necessarily the goal of DT to store all the information that are not
>> board dependent.
>> In this case, each DDR will have it sets of well known AC timings data
>> that will never depend of the board config. In this case, storing that
>> inside DT might not be the best solution.
>>
>> In fact we always had the same kind of discussion for the pinmux data
>> and for the clock data...
>>
>> The conclusion being that most of the static data does not have to be in
>> the DTS.
>> But since Linus was complaining about the huge amount of data inside the
>> kernel, it is not obvious what the best solution is:-)
>
> Hmm.. I get the point now. Linus' complaint is what I had in mind too.
> My humble opinion is to have such data in DTS but re-use it as much as
> possible. That is, we could have something like a "sdram-micron-
> mt46h32m32lf-6.dtsi"(as you suggested before) that can be included by
> board level DTS files. I think the fact that dts files are organized at
> arch level today is limiting such re-use. Please correct me if I am
> wrong.

Gentle reminder on this one. Are we aligned on having the DDR timings
in device tree?

br,
Aneesh
