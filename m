From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Fri, 3 Sep 2010 10:04:03 -0700
Message-ID: <20100903170403.GM11597@atomide.com>
References: <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902162039.GM11597@atomide.com>
 <20100902162537.GU26319@n2100.arm.linux.org.uk>
 <20100902163453.GR11597@atomide.com>
 <20100902234746.GF11597@atomide.com>
 <20100903090734.GJ26319@n2100.arm.linux.org.uk>
 <20100903091029.GK26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0ICREN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 13:04:13 -0400
Content-Disposition: inline
In-Reply-To: <20100903091029.GK26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100903 02:02]:
> On Fri, Sep 03, 2010 at 10:07:34AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Sep 02, 2010 at 04:47:46PM -0700, Tony Lindgren wrote:
> > > Correction, only boots on SMP hardawre. On UP hardware I still
> > > need the following patch.
> > 
> > This should fix that properly.
> 
> Correction - the order of the config tests was wrong.

OK that works now.

Looks like your new patch is missing smp_midr.h BTW.

Tony
