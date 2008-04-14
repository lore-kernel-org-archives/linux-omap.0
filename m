From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Mon, 14 Apr 2008 11:02:09 -0700
Message-ID: <20080414180209.GD26832@atomide.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com> <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com> <20080409121124.GS7338@gandalf.research.nokia.com> <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com> <20080409180557.GA15913@kedavra.cpe.vivax.com.br> <20080409182804.GB24100@pure.research.nokia.com> <fb249edb0804091658i4574e760ye2d6979d9a834d5@mail.gmail.com> <20080410001224.GD5897@intune.research.nokia.com> <fb249edb0804091812g77b6fc84x3312ea09c845ea3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56795 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763340AbYDNSCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:02:15 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0804091812g77b6fc84x3312ea09c845ea3a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Daniel Stone <daniel.stone@nokia.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

* andrzej zaborowski <balrogg@gmail.com> [080409 18:12]:
> On 10/04/2008, Daniel Stone <daniel.stone@nokia.com> wrote:
> > On Thu, Apr 10, 2008 at 01:58:51AM +0200, ext andrzej zaborowski wrote:
> >  > On 09/04/2008, Lauri Leukkunen <lauri.leukkunen@nokia.com> wrote:
> >
> > > > In my opinion kernel should provide "correct" data to user-space, not
> >  > >  some pseudo-random interference from the LCD.
> >  >
> >  > I think this is discutible.  There's a number of userspace libraries
> >  > written to talk tightly to the kernel and make that data more
> >  > "correct", one of them is tslib.  Distros that come with tslib often
> >  > have a set of device-specific config files for tslib which load tslib
> >  > plugins for things like averaging, smoothing, checking bounds on the
> >  > values.
> >  >
> >  > One of the arguments for doing that in userspace is that of avoiding
> >  > every touchscreen driver redoing the same averaging and/or limit
> >  > checking code.  I agree thought that it may be better to sacrifice
> >  > that for performance.
> >
> >
> > If everyone's doing the same thing, move it to drivers/input/, not to
> >  userspace.  Why should we be forced to have _two_ drivers and
> >  essentially maintain a stable kernel/userspace ABI between them? Surely
> >  it's better to only have _one_ hardware-specific driver, rather than
> >  half in the kernel, and half hidden behind an abstraction layer that is
> >  meant to let you just deal with input events without knowing stupid
> >  details about the hardware?
> 
> For the ease of reconfiguration for one thing, tslib is quite
> configurable with the plugins loaded by a config file.  The ABI you
> talk about is the same evdev ABI which is already stable.
> 
> Averaging doesn't just cancel the noise from LCD, just lessens it but
> there may be better things to do with it and the userspace already
> knows how to deal with that. So it expects the kernel driver to be
> more like a ADC driver.
> 
> Of course doing it in drivers/input/ as configured by board files,
> would also work if things were designed that way.

Where to do the filtering should be discussed with the input people.

Meanwhile, I'll push this patch to linux-omap tree.

Tony
