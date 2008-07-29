From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 29 Jul 2008 21:28:52 +0200
Message-ID: <fb249edb0807291228w589d2e87o1deead6883e7c77c@mail.gmail.com>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo>
	 <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com>
	 <20080729191759.GE7275@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:8245 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYG2T2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 15:28:54 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1365hsl.5
        for <linux-omap@vger.kernel.org>; Tue, 29 Jul 2008 12:28:52 -0700 (PDT)
In-Reply-To: <20080729191759.GE7275@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2008/7/29 Felipe Balbi <me@felipebalbi.com>:
> On Tue, Jul 29, 2008 at 02:07:51PM -0500, Woodruff, Richard wrote:
>> > How about renaming it to twl92230c before submitting upstream?  As far
>> > as I can tell the name menelaus appears only in linux and makes it
>> > hard to associate with the real hardware.  Does someone know why was
>> > it renamed that way?
>
>> A number does seem more understandable.  Though some of these chips live under a few different numbers.
>
> it does seem more understandable, but now that it has been used for so
> long I guess it would be nasty to change right now. Almost every one
> here knows that menelaus is the companion chip for omap2 hw. Personally,
> I never recall the correct number designation for menelaus.

Well, menelaus is a friendly name now that I know what it is but it
was difficult to find its datasheet without knowing the public name
used by the manufacturer, it seemed like a nokia's own chip. Also iirc
if you open the device you will only see the TWLxxx name on the chip.

I see TWLxxx is now mentioned in the Kconfig so I won't insist.

Cheers
