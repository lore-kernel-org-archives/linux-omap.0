From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Tue, 29 Nov 2011 16:48:36 -0800
Message-ID: <87k46izb8b.fsf@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
	<87pqh3qvkt.fsf@ti.com>
	<1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
	<a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33682 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752957Ab1K3Asp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 19:48:45 -0500
Received: by iafi7 with SMTP id i7so14729514iaf.24
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 16:48:39 -0800 (PST)
In-Reply-To: <a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com> (Vishwanath
	Sripathy's message of "Tue, 29 Nov 2011 20:29:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

> Hi Kevin,
>
>> -----Original Message-----
>> From: Vishwanath Sripathy [mailto:vishwanath.bs@ti.com]
>> Sent: Tuesday, November 29, 2011 4:53 PM
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
>> support via hwmod mux
>>
>> > -----Original Message-----
>> > From: Kevin Hilman [mailto:khilman@ti.com]
>> > Sent: Tuesday, November 08, 2011 6:28 AM
>> > To: Vishwanath BS
>> > Cc: linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> > Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
>> > support via hwmod mux
>> >
>> > Hi Vishwa,
>> >
>> > Vishwanath BS <vishwanath.bs@ti.com> writes:
>> >
>> > > The folowing patch series provides IO Daisychain feature via
>> omap
>> > hwmod mux
>> > > framework.
>> >
>> > The series looks OK at first glance, but needs a refresh against
>> > current
>> > mainline.
>> OK.
>> >
>> > Can you refresh this against Tony's 'fixes' branch and re-test.
>> >
>> > I tested this on OMAP3430/n900 and noticed that it no longer hit
>> off
>> > mode from idle.
>> >
>> > IOW, If I enable UART timeouts and then enable off mode, I don't
>> > actually ever hit off during idle.  However, if I do a
>> > suspend/resume I
>> > see it hits off mode, then subsequent attempts to hit off during
>> > idle work.
>> >
>> > Can you investigate this?
>> OK. Let me check that.
> I rebased these patches against latest Tony's fixes branch and tested it
> on OMAP3430 SDP. I see that Core enters off mode in idle path after
> setting UART timeout w/o having to suspend the system.

OK, sounds good.

Do you have a branch that I can test as well?

Kevin
