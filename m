From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Thu, 11 Sep 2008 10:33:33 -0700
Message-ID: <20080911173333.GI21163@atomide.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58273 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYIKRdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 13:33:43 -0400
Content-Disposition: inline
In-Reply-To: <20080911091309.GD26078@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080911 02:13]:
> On Thu, Sep 11, 2008 at 09:48:28AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Sep 10, 2008 at 04:56:46PM -0700, Tony Lindgren wrote:
> > > * Madhusudhan Chikkature <madhu.cr@ti.com> [080812 23:13]:
> > > > From: Madhusudhan Chikkature<madhu.cr@ti.com>
> > > > 
> > > > ARM: OMAP3: Enable 4-bit support for HSMMC.
> > > > 
> > > > This patch provides the fix to enable 4-bit support for HSMMC.
> > > 
> > > Pushing today.
> > 
> > So, given my update for this, shouldn't this be something sent almost
> > immediately to me so stuff for mainline isn't falling behind.
> > 
> > Otherwise we're wasting our time trying to get mainline up to date.

Totally.

> New version of the MMC updates for mainline pushed out - with additional
> cleanups in place (and since it's a different patch, I've dropped Tony's
> ack from it.)

While we're at it, let's clean up the mmc mess further and split the
resources to mach-omap1/devices.c and mach-omap2/devices.c. That way
we get rid of the ifdef else between omap1 and omap2.

I'll post some patches for that.

Tony
