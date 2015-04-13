From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
Date: Mon, 13 Apr 2015 14:45:49 -0700
Message-ID: <20150413214549.GA18048@atomide.com>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl>
 <552840A9.8070406@myspectrum.nl>
 <20150411075220.GK12732@n2100.arm.linux.org.uk>
 <5528E88C.4070107@myspectrum.nl>
 <20150413143941.GY18048@atomide.com>
 <20150413162808.GZ18048@atomide.com>
 <20150413213556.GT4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44353 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932940AbbDMVtO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Apr 2015 17:49:14 -0400
Content-Disposition: inline
In-Reply-To: <20150413213556.GT4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jeroen Hofstee <linux-arm@myspectrum.nl>, Catalin Marinas <catalin.marinas@arm.com>, Jeroen Hofstee <jhofstee@victronenergy.com>, Andreas =?utf-8?B?Qmllw59tYW5u?= <andreas.devel@googlemail.com>, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150413 14:37]:
> On Mon, Apr 13, 2015 at 09:28:09AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150413 07:46]:
> > > If what Russell and I are saying is correct, with the above two
> > > patches your system should behave properly with 430973 even if
> > > bit 6 in the aux ctrl register is set (or unset) by the bootloader.
> > > 
> > > If r1p7 is behaves with bit 6 cleared and errata 430973 set, then
> > > we know r1p7 is unaffected by 430973.
> > 
> > Sorry let's take this part again:
> > 
> > If r1p7 is behaves with bit 6 cleared and errata 430973 _unset_,
> > then we know r1p7 is unaffected by 430973.
> 
> I've asked.  The errata applies to _all_ Cortex A8 r1pX versions.
> This is actually what the code in the kernel does today, but the
> documentation does not reflect it.  So, I've updated the
> documentation to reflect (a) the code and (b) the info I received:
> 
> http://ftp.arm.linux.org.uk/cgit/linux-arm.git/commit/?id=59552cc87cb6

OK thanks for checking it, that should clear quite a bit of confusion.

Regards,

Tony
