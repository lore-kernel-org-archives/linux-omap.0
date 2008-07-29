From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Wed, 30 Jul 2008 01:07:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E5@dbde02.ent.ti.com>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo>
	 <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com>
	 <20080729191759.GE7275@frodo>,<fb249edb0807291228w589d2e87o1deead6883e7c77c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbYG2TjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 15:39:17 -0400
In-Reply-To: <fb249edb0807291228w589d2e87o1deead6883e7c77c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 2008/7/29 Felipe Balbi <me@felipebalbi.com>:
>> On Tue, Jul 29, 2008 at 02:07:51PM -0500, Woodruff, Richard wrote:
>>> > How about renaming it to twl92230c before submitting upstream?  As far
>>> > as I can tell the name menelaus appears only in linux and makes it
>>> > hard to associate with the real hardware.  Does someone know why was
>>> > it renamed that way?
>>
>>> A number does seem more understandable.  Though some of these chips live under a few different numbers.
>>
>> it does seem more understandable, but now that it has been used for so
>> long I guess it would be nasty to change right now. Almost every one
>> here knows that menelaus is the companion chip for omap2 hw. Personally,
>> I never recall the correct number designation for menelaus.
>
> Well, menelaus is a friendly name now that I know what it is but it
> was difficult to find its datasheet without knowing the public name
> used by the manufacturer, it seemed like a nokia's own chip. Also iirc
> if you open the device you will only see the TWLxxx name on the chip.
>
> I see TWLxxx is now mentioned in the Kconfig so I won't insist.
>
> Cheers

I think it'll be hard for a newbie to figure out what this menelaus is. Google
won't help either, (unless one really thinks there is a connection between
Linux and Greek Mythology ;) ).

I second renaming the file to TWL92230. Mentioning this in Kconfig is simply
not enough.

My 375 million ZWD,
Anand
