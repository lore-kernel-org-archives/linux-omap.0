From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/12] ARM: OMAP3: mmc-twl4030 add MMC3 support
Date: Sun, 15 Mar 2009 17:40:39 +0000
Message-ID: <20090315174039.GB13220@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211000.16425.62205.stgit@localhost> <20090315160426.GE10786@n2100.arm.linux.org.uk> <6ed0b2680903151027q10a0717fvf73234b2836b0064@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47646 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbZCORku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 13:40:50 -0400
Content-Disposition: inline
In-Reply-To: <6ed0b2680903151027q10a0717fvf73234b2836b0064@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 07:27:32PM +0200, Grazvydas Ignotas wrote:
> On Sun, Mar 15, 2009 at 6:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Mar 10, 2009 at 02:10:00PM -0700, Tony Lindgren wrote:
> >> ... Array size for hsmmc[] is specified
> >> because hsmmc[2].name is needed for MMC3 name.
> >
> > I see nothing in this patch which requires that.
> 
> Right, but there is already some code in twl4030_mmc_init() of mmc-twl4030.c:
> 
>   struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
> <snip>
>   sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> 
> .. which basically writes to hsmmc[2].name for MMC3.

So, it's nothing really to do with hsmmc[2].name being required, it's
more a case of needing to have the 3rd MMC interface included.  The
comment in the commit is *really* misleading.
