From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Tue, 16 Oct 2012 11:26:42 -0700
Message-ID: <20121016182642.GF15569@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17247 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755817Ab2JPS0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 14:26:46 -0400
Content-Disposition: inline
In-Reply-To: <20121016181038.GC15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Tony Lindgren <tony@atomide.com> [121016 11:12]:
> * Ohad Ben-Cohen <ohad@wizery.com> [121014 11:32]:
> > On Fri, Oct 12, 2012 at 6:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> > >> Error setting wl12xx data: -38
> > ..
> > > Ohad, can you please take a look?
> > 
> > Sure, -38 is -ENOSYS which is returned when the wl12xx driver isn't configured.
> > 
> > This isn't an error (it's a user decision, and it shouldn't elicit any
> > error) and the patch below (also attached) should make it go away on:
> > 
> > From 374f145568585c8d6a8d5e4b8b5d3e6baedd2f39 Mon Sep 17 00:00:00 2001
> > From: Ohad Ben-Cohen <ohad@wizery.com>
> > Date: Sun, 14 Oct 2012 20:16:01 +0200
> > Subject: [PATCH] ARM: OMAP: don't print any error when wl12xx isn't
> >  configured
> > 
> > Stop intimidating users with scary wlan error messages in case wl12xx
> > support wasn't even built.
> > 
> > In addition, when wl12xx_set_platform_data() fails, don't bother
> > registering wl12xx's fixed regulator device (on the relevant
> > boards).
> > 
> > While we're at it, extract the wlan init code to a dedicated function to
> > make (the relevant boards') init code look a bit nicer.
> > 
> > Reported-by: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> 
> Thanks applying into omap-for-v3.7-rc1/fixes-part2.

Hmm looking at it repeats the same code over again. Can you
rather add some wl12xx_board_init() helper function to mach-omap2/devices.c
to do it? Dropping this for now.

Regards,

Tony
