From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Sun, 8 Jan 2012 08:56:13 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8075352@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<79CD15C6BA57404B839C016229A409A8071991@DBDE01.ent.ti.com>
 <87aa604q5w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58307 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab2AHI4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 03:56:22 -0500
In-Reply-To: <87aa604q5w.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Saturday, January 07, 2012 12:25 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family
> detection
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> Currently, our SoC detection is based on SoC family detection
> >> (using die ID) and the presence of specific IP blocks (or feature.)
> >>
> >> This series begins the separation of the SoC family detection and
> >> specific IP detection.
> >>
> >> Applies on top of Tony's current master branch and so far, it has only
> >> been compile tested using omap2plus_defconfig.
> >>
> > I tested it on OMAP3EVM (AM37x) and AM3517EVM as well and it is booting
> up
> > for me.
> >
> > Feel free to add my acked and/or tested by.
> 
> Great, thanks for testing!
> 
> Can you also test with the patch 8 that I just sent?   It boot tests
> fine on my AM3517 EVM, but didn't do any other tests.
> 
Yes Kevin,

I have also boot tested it at my end on both AM3517EVM and OMAP3EVM (AM37x)
And it boots up fine for me as well.

Thanks,
Vaibhav



> Thanks,
> 
> Kevin

