From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Fri, 12 Dec 2008 12:35:27 -0800
Message-ID: <5e088bd90812121235j55a9eac5w72721d76984c7ae7@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
	 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
	 <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
	 <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
	 <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
	 <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:7755 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYLLUf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 15:35:28 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1483477wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 12:35:27 -0800 (PST)
In-Reply-To: <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 12, 2008 at 12:15 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:

> On Fri, Dec 12, 2008 at 7:59 PM, Steve Sakoman <sakoman@gmail.com> wrote:
>> What PHY chip are you using on Pandora?
>>
>> From the schematic it appears that Gumstix is using USB3320.

I misread the markings, it is USB3326

>> I'm really puzzled by the difference in behavior :-(
> Unfortunately I don't know, will need to ask out hardware designer.
> The chip is so small that I can't see any markings on it.

No kidding!

> Does your PHY chip heat? There was actually a similar problem with
> rev2 pandora boards, where it would not detect devices and that tiny
> PHY chip would heat really badly. It later turned out to be a bad
> batch of PHY chips, so after switching to another and reflowing the
> boards USB would work fine (almost, with issues above).

No, the chip is cool.  I just reviewed the schematic with data sheet
in hand and it certainly looks like everything is connected properly.

I also compared our u-boot pinmux setup with pandora and we are
identical there.

The mystery deepens . . .

Steve
