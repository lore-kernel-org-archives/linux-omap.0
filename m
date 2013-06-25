From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 0/4] Cleanup PRM and CM regbit headers
Date: Tue, 25 Jun 2013 14:13:37 +0530
Message-ID: <51C95839.6050307@ti.com>
References: <1372076143-12955-1-git-send-email-rnayak@ti.com> <20130625071428.GC5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab3FYIoF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 04:44:05 -0400
In-Reply-To: <20130625071428.GC5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 25 June 2013 12:44 PM, Tony Lindgren wrote:
>> Rajendra Nayak (4):
>> >   ARM: OMAP2: PRM/CM: Cleanup unused header contents
>> >   ARM: OMAP3: PRM/CM: Cleanup unused header contents
>> >   ARM: OMAP4: PRM/CM: Cleanup unused header contents
>> >   ARM: OMAP5: PRM/CM: Cleanup unused header contents
>> > 
>> >  arch/arm/mach-omap2/cm-regbits-24xx.h  |  317 ----
>> >  arch/arm/mach-omap2/cm-regbits-33xx.h  |  758 ---------
>> >  arch/arm/mach-omap2/cm-regbits-34xx.h  |  631 --------
>> >  arch/arm/mach-omap2/cm-regbits-44xx.h  | 1557 -------------------
>> >  arch/arm/mach-omap2/cm-regbits-54xx.h  | 1632 -------------------
>> >  arch/arm/mach-omap2/prm-regbits-24xx.h |  246 ---
>> >  arch/arm/mach-omap2/prm-regbits-33xx.h |  305 ----
>> >  arch/arm/mach-omap2/prm-regbits-34xx.h |  480 ------
>> >  arch/arm/mach-omap2/prm-regbits-44xx.h | 2225 --------------------------
>> >  arch/arm/mach-omap2/prm-regbits-54xx.h | 2677 --------------------------------
>> >  10 files changed, 10828 deletions(-)
> If things build and work after applying this, I suggest we send them
> as a clean-up branch right after -rc1.

They build fine, and I boot tested on the omap4/5 boards that I have too.
(I had the out of tree clock data pulled in for omap5 before I did this
cleanup).

> 
> It seems that build testing and then randconfig testing
> should be enough for these if they are unused and only
> removal.

Right, I'll do more testing and even though they should just boot
fine on the omap2/3 boards too since all thats removed is anyway
unused, I will still do more sanity test before posting them on -rc1.

regards,
Rajendra

