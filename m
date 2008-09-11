From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Thu, 11 Sep 2008 10:13:09 +0100
Message-ID: <20080911091309.GD26078@flint.arm.linux.org.uk>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52852 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYIKJNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 05:13:31 -0400
Content-Disposition: inline
In-Reply-To: <20080911084828.GC26078@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 09:48:28AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 10, 2008 at 04:56:46PM -0700, Tony Lindgren wrote:
> > * Madhusudhan Chikkature <madhu.cr@ti.com> [080812 23:13]:
> > > From: Madhusudhan Chikkature<madhu.cr@ti.com>
> > > 
> > > ARM: OMAP3: Enable 4-bit support for HSMMC.
> > > 
> > > This patch provides the fix to enable 4-bit support for HSMMC.
> > 
> > Pushing today.
> 
> So, given my update for this, shouldn't this be something sent almost
> immediately to me so stuff for mainline isn't falling behind.
> 
> Otherwise we're wasting our time trying to get mainline up to date.

New version of the MMC updates for mainline pushed out - with additional
cleanups in place (and since it's a different patch, I've dropped Tony's
ack from it.)
