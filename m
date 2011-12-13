From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Tue, 13 Dec 2011 11:31:27 -0800
Message-ID: <87wra0uv3k.fsf@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
	<87pqh3qvkt.fsf@ti.com>
	<1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
	<a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com>
	<87k46izb8b.fsf@ti.com>
	<3968ef2671e202d1cefdf4a7c5d32ec6@mail.gmail.com>
	<f1252b7ed1e3731c8b0c18e385dcdc2b@mail.gmail.com>
	<6f34d798db0dcb69747e6fc722cb0cf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46155 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1LMTbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 14:31:34 -0500
Received: by mail-ww0-f54.google.com with SMTP id dt13so17517wgb.23
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 11:31:32 -0800 (PST)
In-Reply-To: <6f34d798db0dcb69747e6fc722cb0cf7@mail.gmail.com> (Vishwanath
	Sripathy's message of "Tue, 13 Dec 2011 19:53:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

> Kevin,
>
>> -----Original Message-----
>> From: Vishwanath Sripathy [mailto:vishwanath.bs@ti.com]
>> Sent: Friday, December 02, 2011 10:29 PM
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
>> support via hwmod mux
>>
>> Kevin,
>>
>> > -----Original Message-----
>> > From: Vishwanath Sripathy [mailto:vishwanath.bs@ti.com]
>> > Sent: Wednesday, November 30, 2011 2:58 PM
>> > To: Kevin Hilman
>> > Cc: linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> > Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
>> > support via hwmod mux
>> >
>> > ---
>> > > >> > Can you refresh this against Tony's 'fixes' branch and re-
>> > test.
>> > > >> >
>> > > >> > I tested this on OMAP3430/n900 and noticed that it no
>> longer
>> > > hit
>> > > >> off
>> > > >> > mode from idle.
>> > > >> >
>> > > >> > IOW, If I enable UART timeouts and then enable off mode, I
>> > > don't
>> > > >> > actually ever hit off during idle.  However, if I do a
>> > > >> > suspend/resume I
>> > > >> > see it hits off mode, then subsequent attempts to hit off
>> > > during
>> > > >> > idle work.
>> > > >> >
>> > > >> > Can you investigate this?
>> > > >> OK. Let me check that.
>> > > > I rebased these patches against latest Tony's fixes branch and
>> > > tested it
>> > > > on OMAP3430 SDP. I see that Core enters off mode in idle path
>> > > after
>> > > > setting UART timeout w/o having to suspend the system.
>> > >
>> > > OK, sounds good.
>> > >
>> > > Do you have a branch that I can test as well?
>> > Sure. It's available at
>> > git://gitorious.org/omap-pm/linux.git for_3.3/io_daisy_chain
>> Did you get any chance to test it at your side?
>> Should I post the rebased patches?
> I have rebased these patch series against LO master commit id:
> deee6d5359969a0ce4e2760cfd7b9f379bd5698a and same is available here [1].
>
> I have tested these patch series along with Tero's Chain Handler +
> Govind's UART Runtime series which is available at [2].

Thanks.

Can you repost the latest version, with tested-bys as appropriate and
describing how it was tested and on what platforms.

This series has several dependencies/conflicts with Tero's series, so it
would be helpful that the posted version is based on Tero's stuff.

Since Tero's stuff is going through Paul, your series will as well (if
Paul is OK with it.) 

Kevin
