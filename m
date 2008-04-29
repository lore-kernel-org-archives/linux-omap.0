From: Brian Swetland <swetland@google.com>
Subject: Re: Questions on Android
Date: Tue, 29 Apr 2008 03:13:51 -0700
Message-ID: <20080429101351.GA25657@bulgaria.corp.google.com>
References: <20080429090628.GB25363@bulgaria.corp.google.com> <200804290948.m3T9mLHt021830@smtp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:5757 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYD2KOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 06:14:23 -0400
Content-Disposition: inline
In-Reply-To: <200804290948.m3T9mLHt021830@smtp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil S <anils@mistralsolutions.com>
Cc: 'Dirk Behme' <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org, colorant@163.com

[Anil S <anils@mistralsolutions.com>]
> Hello Brian,
> 
> 	It would be really great if you could share thoughts on the
> questions given here on Android:
> 
> I was able to add support for the keypad, touch and network in Android,
> however the interfaces like GPS, Accelerometer, vibrator, hardware 3D
> acceleration, battery etc. are not integrated with Android right now. I
> would appreciate if you could throw some light on these open issues. How
> exactly can these interfaces be integrated with Android? 

We're trying to use the standard kernel/driver interfaces when possible,
but for things that may have a good deal of variation in implementation,
we're looking to provide a very thin "hardware interface library" layer
to adapt between the bottom of the userspace stack and the drivers or
whatnot for specific hardware platforms.  

We'll continue to adopt standardized kernel solutions as they become
available -- We're now using the power supply framework in 2.6.24 for
monitoring battery/charge state (post M5 SDK -- it'll be in the next 
release), for example.

Brian
