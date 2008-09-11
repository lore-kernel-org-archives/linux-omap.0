From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Thu, 11 Sep 2008 19:13:12 +0100
Message-ID: <20080911181312.GC4986@flint.arm.linux.org.uk>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57797 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYIKSN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 14:13:29 -0400
Content-Disposition: inline
In-Reply-To: <20080911173333.GI21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 10:33:33AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080911 02:13]:
> > New version of the MMC updates for mainline pushed out - with additional
> > cleanups in place (and since it's a different patch, I've dropped Tony's
> > ack from it.)
> 
> While we're at it, let's clean up the mmc mess further and split the
> resources to mach-omap1/devices.c and mach-omap2/devices.c. That way
> we get rid of the ifdef else between omap1 and omap2.

Great, it would be nice to get something in OMAP to the point where we
can say it's finished, and doesn't have to be regularly tinkered with
anymore.

Is there anything else that the MMC stuff is missing at present?
