From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Mon, 29 Jul 2013 08:29:24 -0400
Message-ID: <51F66024.1030804@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com> <51CB4C20.3060306@ti.com> <alpine.DEB.2.02.1307290826180.30864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab3G2M3t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 08:29:49 -0400
In-Reply-To: <alpine.DEB.2.02.1307290826180.30864@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On 07/29/2013 04:29 AM, Paul Walmsley wrote:
> Hi
> 
> On Wed, 26 Jun 2013, Tom Rini wrote:
> 
>> On 06/26/2013 01:19 PM, Paul Walmsley wrote:
>>> On Tue, 25 Jun 2013, Tom Rini wrote:
>>>
>>>> On 06/25/2013 02:20 PM, Paul Walmsley wrote:
>>>>
>>>>> BeagleBone-white has the additional complication that it is not easy 
>>>>> to automate, due to the way that power is delivered to the board, so 
>>>>> there is an extra dimension of difficulty there.
>>>>
>>>> Ah-ha, I reproduced your failure.  If I make up a concat uImage + DTB,
>>>> rather than pass them separately, it fails to boot.  If you switch to
>>>> mainline U-Boot (v2012.10 or later) you get support for separate image +
>>>> dtb (v2013.04 gives you bootz and zImage support).
>>>
>>> Yeah, I've tried to keep the original bootloader that came on the first SD 
>>> card image that was used on that device.  But am starting to think that 
>>> it's time to stop my bootloader independence jihad, since appended DTB 
>>> booting is so broken - have seen similar problems on SoCs from other 
>>> vendors as well :-(
>>
>> Well, me?  I'm all in favor of people using latest release of U-Boot for
>> their board and yelling and screaming (or just reporting bugs) when
>> things don't work.  I'm biased of course.
> 
> That's exactly how bootloader developers should be testing their changes.  
> But most of the rest of us kernel folks don't want to deal with constantly 
> replacing bootloaders, and then dealing with the inevitable bootloader 
> regressions, when what we're really trying to test is the kernel...
> The kernel should be completely independent of the bootloader used.  

And thus the chicken and egg problems we have today.  The kernel should
be independent, but unless someone is also testing more recent U-Boots
as well, we may or may not have more hidden clock problems.  Or if there
is a bug in the bootloader for some particular use case, we don't find
out until a new device ships out with broken code for that case, and now
we're stuck for "forever".

I don't suspect what I'm going to say now will have a lot of traction,
but I really think that much like user space, every once in a while (6
months? year?) one ought to update their environment and make sure
things are still working too.

You folks don't need to test ever rev of U-Boot (that's my job), but it
often feels like there's this cycle of "U-Boot sucks and can't do ... !"
"We've had that fixed / improved / changed for years now, upgrade?" "No,
can't / won't!".  And...

>> And assuming rmk answers the way I expect he will, like it or not, the 
>> version(s) we kit up and get in the box need to be factored into our 
>> test system setup so if folks don't want to avail themselves of 
>> improvements, they still get a functional system too.
> 
> Yep seems like a good idea from a customer service point of view.  Also 
> most OMAP devices out there probably have locked bootloaders, so replacing 
> the bootloader is often not an option.

For shipping consumer product, or however you want to call those kind of
devices, yes, appended dtb needs to work since the bootloader is locked,
and making that boot something else to boot the kernel is an exercise
for us oddballs :)  But the boards which are designed as reference
platform, we can make your lives easier, if you let us help.  If
something is a pain to do, give us feedback.

-- 
Tom
