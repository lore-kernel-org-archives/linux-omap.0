From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: patch "phy: Add a driver for dm816x USB PHY" added to linux-phy
 tree
Date: Tue, 31 Mar 2015 22:06:14 +0530
Message-ID: <551ACCFE.3070703@ti.com>
References: <20150325233606.GA7549@a0393678ub> <CAALWOA9ZHM6S+7WUffu0LF=9=fEO+PxfERpu=D9JpAbKSo1yNA@mail.gmail.com> <20150326160416.GG31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49758 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbbCaQg0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 12:36:26 -0400
In-Reply-To: <20150326160416.GG31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, Bin Liu <binmlist@gmail.com>, pebolle@tiscali.nl, rusty@rustcorp.com.au, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On Thursday 26 March 2015 09:34 PM, Tony Lindgren wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150326 00:02]:
>> On 26 March 2015 at 00:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Let me know if you find any problems with this patch.
>>
>> I spotted a minor issue in drivers/phy/Kconfig:
>>
>>> +         Enable this for dm81xx USB to work.
>>
>> This should say dm816x instead.
>
> Yes that's correct, the phy on dm814x seems to be like on am335x,
> not like on dm816x. Kishon, let me know if you prefer a follow-up
> patch to fix this.

No. I've fixed this in my tree
https://git.kernel.org/cgit/linux/kernel/git/kishon/linux-phy.git/commit
/?h=next&id=9fa9fd4ffc90582091b8c6219f2054265f71e4ef
>
> I'm not seeing the original mail for this thread anywhere for some
> reason BTW. It does not seem to be in the mailing list archives
> either, well at least not yet.

It's an automated mail that is sent to notify the authors and other who are
explicitly added in the signed-off by section when a patch is being merged in
the linux-phy tree. So it won't be in the mailing list archives.

But I'm not sure why you didn't receive it :-(

Thanks
Kishon
