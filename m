From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Mon, 19 Jan 2009 14:42:49 -0800
Message-ID: <200901191442.49561.david-b@pacbell.net>
References: <20090116083709.18344.74524.stgit@oreo.research.nokia.com> <20090119.114407.177399457.Hiroshi.DOYU@nokia.com> <20090119215858.GA31848@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:35729 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751732AbZASWmv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2009 17:42:51 -0500
In-Reply-To: <20090119215858.GA31848@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Monday 19 January 2009, Russell King - ARM Linux wrote:
> 
> > > Use dev_vdbg() to get the "NOP unless VERBOSE is set" semantics.
> > 
> > Thanks. This is what I wanted... I'll update with "dev_vdbg()".
> 
> Sorry, drop the 'v' in that (typo).

Not clear what that comment means ... dev_vdbg() is the same as
dev_dbg() *IF* the VERBOSE option is set, and is otherwise a NOP.

That is:  two levels of debug messaging, for use as needed.
As a rule, some Kconfig option will

  ccflags-$(CONFIG_DEBUG_whatever)    += -DDEBUG

to enable DEBUG for that subsystem, and the VERBOSE option
(see <linux/device.h>) is set selectively by hand.

- Dave
