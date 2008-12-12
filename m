From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Sat, 13 Dec 2008 00:54:35 +0200
Message-ID: <6ed0b2680812121454y21e3dc5co92246524657c2d81@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
	 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
	 <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
	 <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
	 <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
	 <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
	 <5e088bd90812121235j55a9eac5w72721d76984c7ae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:56045 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbYLLWyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 17:54:36 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1585660rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 14:54:36 -0800 (PST)
In-Reply-To: <5e088bd90812121235j55a9eac5w72721d76984c7ae7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 12, 2008 at 10:35 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Fri, Dec 12, 2008 at 12:15 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>
>> On Fri, Dec 12, 2008 at 7:59 PM, Steve Sakoman <sakoman@gmail.com> wrote:
>>> What PHY chip are you using on Pandora?
>>>
>>> From the schematic it appears that Gumstix is using USB3320.
>
> I misread the markings, it is USB3326

I've received a response from our hardware designer:

The USB3326 is garbage.  That is the chip that was overheating for us on
these rev2 boards.  Tell them to switch to the USB3322 like Pandora and
Beagle now officially use. ;)  The Beagle had issues on the 26 as well.

:-D
