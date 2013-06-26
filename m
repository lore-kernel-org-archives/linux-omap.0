From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 16:16:32 -0400
Message-ID: <51CB4C20.3060306@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab3FZUQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jun 2013 16:16:20 -0400
In-Reply-To: <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On 06/26/2013 01:19 PM, Paul Walmsley wrote:
> On Tue, 25 Jun 2013, Tom Rini wrote:
> 
>> On 06/25/2013 02:20 PM, Paul Walmsley wrote:
>>
>>> BeagleBone-white has the additional complication that it is not easy 
>>> to automate, due to the way that power is delivered to the board, so 
>>> there is an extra dimension of difficulty there.
>>
>> Ah-ha, I reproduced your failure.  If I make up a concat uImage + DTB,
>> rather than pass them separately, it fails to boot.  If you switch to
>> mainline U-Boot (v2012.10 or later) you get support for separate image +
>> dtb (v2013.04 gives you bootz and zImage support).
> 
> Yeah, I've tried to keep the original bootloader that came on the first SD 
> card image that was used on that device.  But am starting to think that 
> it's time to stop my bootloader independence jihad, since appended DTB 
> booting is so broken - have seen similar problems on SoCs from other 
> vendors as well :-(

Well, me?  I'm all in favor of people using latest release of U-Boot for
their board and yelling and screaming (or just reporting bugs) when
things don't work.  I'm biased of course.  And assuming rmk answers the
way I expect he will, like it or not, the version(s) we kit up and get
in the box need to be factored into our test system setup so if folks
don't want to avail themselves of improvements, they still get a
functional system too.

-- 
Tom
