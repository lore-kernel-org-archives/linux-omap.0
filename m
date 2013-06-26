From: Kevin Hilman <khilman@linaro.org>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 13:56:10 -0700
Message-ID: <87ppv8r3px.fsf@linaro.org>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
	<20130625160243.GE22312@arwen.pp.htv.fi>
	<alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
	<51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
	<79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39059 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3FZU4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 16:56:14 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so1673091pdj.14
        for <linux-omap@vger.kernel.org>; Wed, 26 Jun 2013 13:56:14 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
	(Vaibhav Hiremath's message of "Wed, 26 Jun 2013 04:53:14 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Rini, Tom" <trini@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces@lists.infradead.org] On Behalf Of Kevin Hilman
>> Sent: Wednesday, June 26, 2013 1:28 AM
>> To: Rini, Tom
>> Cc: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Balbi, Felipe; Hiremath, Vaibhav
>> Subject: Re: OMAP baseline test results for v3.10-rc6
>> 
>> Tom Rini <trini@ti.com> writes:
>> 
>> > On 06/25/2013 02:20 PM, Paul Walmsley wrote:
>> >> + Vaibhav and Kevin
>> >>
>> >> Hi,
>> >>
>> >> On Tue, 25 Jun 2013, Felipe Balbi wrote:
>> >>
>> >>> On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
>> >>>> Boot to userspace:
>> >>>>     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
>> >>>
>> >>> Paul, we have at least 2 different folks who can't reproduce your
>> bone
>> >>> and bone black boot to userspace failures. I wonder how you're
>> trying to
>> >>> boot them.
>> >>>
>> >>> Care to share your test scripts ?
>> >>
>> >> Sure... the methodology is completely open and has been posted in
>> the
>> >> online logs since the first test cycle.  (For some reason, almost no
>> one
>> >> clicks through the test directory trees that I post online.  Is this
>> a
>> >> documentation issue?  What can we do to make it easier for people to
>> >> explore this?)
>> >
>> > Well, another link never hurts the search results :)
>> >
>> > [snip]
>> >> Am certainly open to the idea that there's something wrong with the
>> way
>> >> that I'm booting either of these.  But AFAIK no one's been able to
>> >> identify exactly what it could be.  I haven't had the time recently
>> to
>> >> spend hours going through the various permutations, given all the
>> other
>> >> breakage :-(  BeagleBone-white has the additional complication that
>> it is
>> >> not easy to automate, due to the way that power is delivered to the
>> board,
>> >> so there is an extra dimension of difficulty there.
>> >
>> > Ah-ha, I reproduced your failure.  If I make up a concat uImage +
>> DTB,
>> > rather than pass them separately, it fails to boot.  If you switch to
>> > mainline U-Boot (v2012.10 or later) you get support for separate
>> image +
>> > dtb (v2013.04 gives you bootz and zImage support).  v2013.04 will
>> also
>> > work out of the box for BeagleBone-Black.
>> 
>> Just to confirm, my problems with mainline were with appended DTB also.
>> Separate DTB and zImage work fine (at least using u-boot v2013.04.)
>> 
>> That being said, appended DTB should still work, so there's a bug
>> hiding
>> someplace that needs to be found fixed.
>> 
>> Can you guys update your tests to test appended DTB also?
>> 
>
> What is missing here is, 
>
> CONFIG_ARM_APPENDED_DTB = y
> CONFIG_ARM_ATAG_DTB_COMPAT = y

Yes, yes... I use these options since I use appended DT with mainline
for *many* boards. Only the beaglebone stopped working.

I just tested v3.10-rc7 and it's back to working again for me with
appended DT.  I did not spend anymore time to figure out exactly which
versions worked or didn't work.

Kevin
