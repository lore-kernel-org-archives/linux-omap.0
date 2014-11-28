From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] move omap gpmc to drivers finally
Date: Fri, 28 Nov 2014 23:41:40 +0100
Message-ID: <4073059.QNMRS4hN3Z@wuerfel>
References: <20141126194330.GN2817@atomide.com> <201411281228.52786.arnd@arndb.de> <20141128213915.GV2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64633 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaK1Wlo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 17:41:44 -0500
In-Reply-To: <20141128213915.GV2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On Friday 28 November 2014 13:39:16 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [141128 03:31]:
> > On Wednesday 26 November 2014, Tony Lindgren wrote:
> > >
> > > We can finally move the GPMC code to live in drivers/memory
> > > for further clean up work. This series does the move with
> > > minimal changes to the code.
> > 
> > I just looked at this branch. It's definitely nice to move the code
> > to drivers/memory, but I don't like the idea of having lots of function
> > declarations and internal data structures in a linux/platform_data/*.h
> > file. We can still merge this for 3.19, but I want to make sure you have
> > a plan for getting rid of this (and put that into the tag description).
> > 
> > Does this header file get removed once all non-DT board files are gone?
> 
> Yes that will become driver internal data at that point.

Ok, cool.

> > How about moving the declarations into include/linux/omap-gpmc.h instead?
> 
> OK. Below is an updated pull request with the platform_data/omap-gpmc.h
> dropped.

Pulled into next/omap-gpmc, thanks!

I guess we'll end up merging this branch into next/drivers before submitting,
but I have to see the relative sizes first. If it's a significant chunk of
the drivers changes, we might submit it as one branch to Linus.

	Arnd
