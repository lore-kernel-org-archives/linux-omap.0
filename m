From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
Date: Wed, 30 May 2012 11:33:37 +0300
Message-ID: <1338366817.8834.125.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
	 <871umj4qnl.fsf@ti.com> <1337593097.28274.19.camel@sokoban>
	 <87pq9mg2w4.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab2E3Idm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 04:33:42 -0400
In-Reply-To: <87pq9mg2w4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-05-29 at 13:15 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
> >> +Benoit
> >> 
> >> Tero Kristo <t-kristo@ti.com> writes:
> >> 
> >> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> >> > otherwise the secure ROM code will crash.
> >> >
> >> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> 
> >> I think I mentioned this already (I'm already lost in what I've said for
> >> thisseries), but I don't think the secure RAM stuff belongs in the
> >> wakeupgen driver.
> >
> > As mentioned, save_secure_all saves:
> > - secure RAM
> > - GIC registers
> > - some other mysterious stuff
> >
> > Attempting to do separate saves for secure RAM + GIC hang the device
> > during wakeup, in addition to being really inefficient (secure API calls
> > are expensive.)
> 
> I guess my comment wasn't that this isn't needed, but that it doesn't
> seem to belong in the wakeupgen base (which should probably converted
> into a real driver.)
> 
> Seems better to have this stuff in the secure code, maybe omap-secure.c?

That might be an option yes. I'll see if I can move these calls over
there.

-Tero

