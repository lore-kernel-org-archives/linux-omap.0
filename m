From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 22:41:10 +0200
Message-ID: <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:54962 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbYLKUlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 15:41:11 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1046806rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 12:41:10 -0800 (PST)
In-Reply-To: <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Paul Walmsley <paul@booyaka.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Dec 11, 2008 at 7:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Thu, Dec 11, 2008 at 8:49 AM, Paul Walmsley <paul@booyaka.com> wrote:
>> Hi Grazvydas, Steve,
>>
>> On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:
>>
>>> > Can you please post whatever patches you need to apply to make it work
>>> > occasionally so others can also look at the issue?
>>>
>>> For pandora, making infinite while loops finite doesn't help much,
>>> kernel crashes later on. Steve had this too:
>>> http://marc.info/?l=linux-omap&m=122378604027303&w=2
>>>
>>> I did bisect and found that commit
>>> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
>>> Reverting this makes EHCI work again on pandora.
>>> http://marc.info/?l=linux-omap&m=122453174024860&w=2
>>
>> Would one of you be willing to run with this patch and send back any debug
>> output relating to dpll5_ck ?  (Unfortunately, I don't have access to any
>> boards with EHCI hardware, so cannot try it myself)
>>
>> This will help determine what fix should be applied
>
> Here you go.  Note that no infinite loop!

Ah, so it no longer needs that revert, probably recent clock changes
fixed that issue.

> ...
> Result: no hang at boot, but I still end up with the auto suspend,
> though the behavior is slightly different (dmesg output this time
> since it contains more debug info):

If your host uses PHY mode, have you hacked EXT_PHY_RESET_GPIO* in
drivers/usb/host/ehci-omap.c? BTW, if this stuff is really needed, it
should go to platform_data..
