From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC
 NAND on non-OMAP platforms
Date: Sat, 16 Apr 2016 10:57:11 +0200
Message-ID: <20160416105711.5310d2d0@bbrezillon>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
	<20160413212500.GD5995@atomide.com>
	<5710B58C.7050108@ti.com>
	<20160415120942.3131eac1@bbrezillon>
	<5710C86A.9060108@ti.com>
	<20160415135108.63716f06@bbrezillon>
	<20160415154139.GS5995@atomide.com>
	<20160415180531.15d790d2@bbrezillon>
	<20160415161950.GT5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160415161950.GT5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 15 Apr 2016 09:19:51 -0700
Tony Lindgren <tony@atomide.com> wrote:

> 
> > Or should I just pull this immutable branch in my current nand/next and
> > let you pull the same immutable branch in omap-soc. I mean, would this
> > prevent conflicts when our branches are merged into linux-next, no
> > matter the order.
> 
> Ideally just one or more branches with just minimal changes in
> them against -rc1. But you may have other dependencies in
> your NAND tree so that may no longer be doable :) Usually if
> I merge something that may need to get merged into other
> branches, I just apply them into a separate branch against -rc1
> to start with, then merge that branch in.

Okay, in this case, that's pretty much what I did from the beginning,
except the immutable branch was provided by Roger (based on 4.6-rc1).
Thanks for this detailed explanation, I'll try to remember that when
I'll need to provide an immutable branch for another subsystem.

Roger, my request remains, could you check/test my conflict resolution
(branch nand/next-with-gpmc-rework)?

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
