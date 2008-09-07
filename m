From: David Brownell <david-b@pacbell.net>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sat, 6 Sep 2008 22:23:10 -0700
Message-ID: <200809062223.10845.david-b@pacbell.net>
References: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:20503 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751107AbYIGFXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 01:23:12 -0400
In-Reply-To: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 06 September 2008, Steve Sakoman wrote:
> On Fri, Sep 5, 2008 at 10:52 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Steve Sakoman <sakoman@gmail.com> [080905 10:24]:
> >> > Hmm, is the musb broken now?
> >>
> >> It is on Overo if I base my patches against current top of tree
> >> (a376251519ced5831ed07ed234430725230ed93a)
> >>
> >> Doesn't crash, just quietly doesn't work.  I hear from Beagle folk
> >> that musb doesn't work there either.  ...

A while back I tried a patch making the rc3-omap code match mainline
(more or less) on Beagle, and it failed ... so I've been tracking
down various RC3 issues.

I don't have all of them yet, but various "used to work" (on DaVinci
and TUSB6010) scenarios -- plugging/unplugging the B side of a cable
(Beagle == host), reboot with cable connected (Beagle == peripheral)
are being trouble.

There's also a notification issue with CDC Ethernet ... if the usb0
interface (Beagle == peripheral) is brought up before the host gets
connected, the host can't talk to it.  I just sent that patch in:

  http://marc.info/?l=linux-usb&m=122076214105934&w=2

 
> Mans has a patch in his git:
> 
> http://git.mansr.com/?p=linux-omap;a=commitdiff;h=1e5bc41773bb981b3a89bd762becf98c72be5e4c
> 
> Neither of us understand musb details enough to propose this as *the*
> fix, but it seems likely to be the issue.

Missing that should probably make trouble, yes.

