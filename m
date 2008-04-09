From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Thu, 10 Apr 2008 01:58:51 +0200
Message-ID: <fb249edb0804091658i4574e760ye2d6979d9a834d5@mail.gmail.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com>
	 <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com>
	 <20080409121124.GS7338@gandalf.research.nokia.com>
	 <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com>
	 <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
	 <20080409182804.GB24100@pure.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:8470 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYDIX6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 19:58:53 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3882685mue.5
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 16:58:51 -0700 (PDT)
In-Reply-To: <20080409182804.GB24100@pure.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Stone <daniel.stone@nokia.com>

Hi,

On 09/04/2008, Lauri Leukkunen <lauri.leukkunen@nokia.com> wrote:
> On 09/04/08 21:05 +0300, ext Felipe Balbi wrote:
>  > On Wed, Apr 09, 2008 at 07:26:31PM +0200, andrzej zaborowski wrote:
>
> > > Question not really related to this patchset, but in the TSC2005
>  > > driver some averaging and limit checks are done to the ADC values.
>  > > Shouldn't that be done in userspace instead?  (The ADS784x and TSC2301
>  > > drivers do the same evidently.)
>  >
>  > Now that's not really up to me, but if we move it now it probably won't
>  > provide the feature n810 needs. I mean, n810 is designed on top of the
>  > features provided by driver, the application probably expects the driver
>  > to do the averaging and limit checks so at least for tsc2005 I think
>  > it's not a good idea to change due to application requirements.
>
>
> User-space is too late for this filtering, we would end up feeding ~1k samples
>  per second there, and that would simply clog the system pretty badly, can't
>  do much buffering either as that degrades interactive responsiveness of the
>  UI.

That's true, that'd send to userspace the amount of data multiplied by
the number of samples over which the averaging is done.  I don't know
how significant amount that would be.

> In my opinion kernel should provide "correct" data to user-space, not
>  some pseudo-random interference from the LCD.

I think this is discutible.  There's a number of userspace libraries
written to talk tightly to the kernel and make that data more
"correct", one of them is tslib.  Distros that come with tslib often
have a set of device-specific config files for tslib which load tslib
plugins for things like averaging, smoothing, checking bounds on the
values.

One of the arguments for doing that in userspace is that of avoiding
every touchscreen driver redoing the same averaging and/or limit
checking code.  I agree thought that it may be better to sacrifice
that for performance.

Cheers
