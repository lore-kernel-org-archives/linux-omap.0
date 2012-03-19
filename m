From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
Date: Mon, 19 Mar 2012 16:39:11 -0700
Message-ID: <20120319233910.GF9859@atomide.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <20120319191743.GB9859@atomide.com>
 <4F67B9F9.1030906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab2CSXjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 19:39:14 -0400
Content-Disposition: inline
In-Reply-To: <4F67B9F9.1030906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120319 16:00]:
> Hi Tony,
> 
> On 3/19/2012 8:17 PM, Tony Lindgren wrote:
> >* Tarun Kanti DebBarma<tarun.kanti@ti.com>  [120319 05:09]:
> >>These two patches incorporate changes to OMAP1 and OMAP2 platforms
> >>board files whereby older references to OMAP_GPIO_IRQ macro are
> >>now replaced with gpio_to_irq(), thereby getting rid of static
> >>irq references.
> >>
> >>Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
> >>Commit: 9a0cee711448335ec43eae83272495e9334c0098
> >
> >Can you please tell the exact two commits causing this
> >breakage?
> 
> Well, this is the GPIO DT + SPARSE_IRQ series I have done. It
> appears that the boards I have were already using properly
> gpio_to_irq() and thus were working fine with this series.
> 
> But this is unfortunately not the case of most OMAP2 and 3 legacy
> boards that were still using an old OMAP way of converting GPIO to
> IRQ and were never modified to take advantage of the gpiolib stuff.
> 
> So if these patches are apply before the GPIO DT + SPARSE_IRQ
> series, there will be no breakage at all.
> 
> All the cleanup we have never done before will hurt us at some point
> when we will start using more extensively newer fmwk (DT,
> sparse_irq, dmaengine...). It was not done on purpose, but this GPIO
> series highlighted this remaining static broken mapping inside OMAP
> boards.

Yes I understand. But still, which patch(s) cause the issue
so we can put that in the changelog for the fixes?
 
> >I'm baffled how despite all the effort for previnting
> >issues like this this still happen. These all seem valid
> >fixes and clean up things, but how come this was not seen
> >earlier?
> 
> Maybe because there are much more boards inside mach-omap2 directory
> than inside my cubicle... :-(

Well somehow we need to make sure that patches get properly
tested on a reasonable selection of boards. This pretty much
breaks things for 21 boards out of the 51 board-*.c files :(

Regards,

Tony
