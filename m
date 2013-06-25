From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 25 Jun 2013 16:22:29 -0400
Message-ID: <51C9FC05.4070700@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab3FYUWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 16:22:20 -0400
In-Reply-To: <87fvw6t136.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hvaibhav@ti.com

On 06/25/2013 03:57 PM, Kevin Hilman wrote:
> Tom Rini <trini@ti.com> writes:
> 
>> On 06/25/2013 02:20 PM, Paul Walmsley wrote:
>>> + Vaibhav and Kevin
>>>
>>> Hi,
>>>
>>> On Tue, 25 Jun 2013, Felipe Balbi wrote:
>>>
>>>> On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
>>>>> Boot to userspace:
>>>>>     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
>>>>
>>>> Paul, we have at least 2 different folks who can't reproduce your bone
>>>> and bone black boot to userspace failures. I wonder how you're trying to
>>>> boot them.
>>>>
>>>> Care to share your test scripts ?
>>>
>>> Sure... the methodology is completely open and has been posted in the 
>>> online logs since the first test cycle.  (For some reason, almost no one 
>>> clicks through the test directory trees that I post online.  Is this a 
>>> documentation issue?  What can we do to make it easier for people to 
>>> explore this?)
>>
>> Well, another link never hurts the search results :)
>>
>> [snip]
>>> Am certainly open to the idea that there's something wrong with the way 
>>> that I'm booting either of these.  But AFAIK no one's been able to 
>>> identify exactly what it could be.  I haven't had the time recently to 
>>> spend hours going through the various permutations, given all the other 
>>> breakage :-(  BeagleBone-white has the additional complication that it is 
>>> not easy to automate, due to the way that power is delivered to the board, 
>>> so there is an extra dimension of difficulty there.
>>
>> Ah-ha, I reproduced your failure.  If I make up a concat uImage + DTB,
>> rather than pass them separately, it fails to boot.  If you switch to
>> mainline U-Boot (v2012.10 or later) you get support for separate image +
>> dtb (v2013.04 gives you bootz and zImage support).  v2013.04 will also
>> work out of the box for BeagleBone-Black.
> 
> Just to confirm, my problems with mainline were with appended DTB also.
> Separate DTB and zImage work fine (at least using u-boot v2013.04.)
> 
> That being said, appended DTB should still work, so there's a bug hiding
> someplace that needs to be found fixed.

Since we've narrowed down what the problem is, someone can bisect it
now, yeah.

> Can you guys update your tests to test appended DTB also?

What is the official position on appending DTBs?

-- 
Tom
