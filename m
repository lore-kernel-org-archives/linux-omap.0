From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Fri, 12 Dec 2008 22:15:30 +0200
Message-ID: <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
	 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
	 <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
	 <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
	 <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:50551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYLLUPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 15:15:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1531318rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 12:15:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 12, 2008 at 1:09 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Grazvydas,
>
> On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:
>
>> On Thu, Dec 11, 2008 at 11:07 PM, Paul Walmsley <paul@booyaka.com> wrote:
>> > Gravyzdas, can you send us a commit ID that results in successful device
>> > enumeration (after reverting
>> > http://marc.info/?l=linux-omap&m=122453174024860&w=2 ?)  Sounds like it
>> > was working for you in late October with that revert.
>>
>> There is no need to - EHCI works (almost) fine on pandora with current HEAD.
>
> Might you be willing to try a build with the first two patches
> from this series posted earlier today with the subject:
>
> [PATCH 0/3 NOT FOR MERGING] ehci-omap clock rewrite test patches
>
> and see if things still almost work?  If so, then we can get the nasty
> direct CM writes out of that driver.
Yes, with those it works exactly as without them (at least I haven't
noticed any difference).

>> I'm also getting suspend/resume related problems if I plug a hub
>> without any devices connected (29sec), and then a device (52sec):
>
> If you disable USB autosuspend with no devices connected via
>
> echo -1 > /sys/module/usbcore/parameters/autosuspend
>
> and then repeat the same test as above, do your devices stay alive?
Yep, this seems to resolve that issue, I can plug the devices any way
I want with this. Thanks for showing this.

On Fri, Dec 12, 2008 at 7:59 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Thu, Dec 11, 2008 at 12:41 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>
>> If your host uses PHY mode, have you hacked EXT_PHY_RESET_GPIO* in
>> drivers/usb/host/ehci-omap.c? BTW, if this stuff is really needed, it
>> should go to platform_data..
>
> What PHY chip are you using on Pandora?
>
> From the schematic it appears that Gumstix is using USB3320.
>
> I'm really puzzled by the difference in behavior :-(
Unfortunately I don't know, will need to ask out hardware designer.
The chip is so small that I can't see any markings on it.

Does your PHY chip heat? There was actually a similar problem with
rev2 pandora boards, where it would not detect devices and that tiny
PHY chip would heat really badly. It later turned out to be a bad
batch of PHY chips, so after switching to another and reflowing the
boards USB would work fine (almost, with issues above).
