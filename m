From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Fri, 3 Sep 2010 20:36:45 +0100
Message-ID: <20100903193645.GB2978@n2100.arm.linux.org.uk>
References: <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902162039.GM11597@atomide.com> <20100902162537.GU26319@n2100.arm.linux.org.uk> <20100902163453.GR11597@atomide.com> <20100902234746.GF11597@atomide.com> <20100903090734.GJ26319@n2100.arm.linux.org.uk> <20100903091029.GK26319@n2100.arm.linux.org.uk> <20100903170403.GM11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35525 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab0ICTgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 15:36:53 -0400
Content-Disposition: inline
In-Reply-To: <20100903170403.GM11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Fri, Sep 03, 2010 at 10:04:03AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100903 02:02]:
> > On Fri, Sep 03, 2010 at 10:07:34AM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Sep 02, 2010 at 04:47:46PM -0700, Tony Lindgren wrote:
> > > > Correction, only boots on SMP hardawre. On UP hardware I still
> > > > need the following patch.
> > > 
> > > This should fix that properly.
> > 
> > Correction - the order of the config tests was wrong.
> 
> OK that works now.
> 
> Looks like your new patch is missing smp_midr.h BTW.

Damn git.  Hate it when keeping patches external to git, even in git diff
form.  Luckily the file is just sitting around in my tree rather than
having been deleted entirely...
