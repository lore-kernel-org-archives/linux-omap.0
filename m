From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: Do early I/O mapping if spinlock debugging is enabled
Date: Wed, 28 Jan 2009 18:53:55 +0000
Message-ID: <20090128185355.GC23301@n2100.arm.linux.org.uk>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182305.21007.62781.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55365 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbZA1SyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:54:09 -0500
Content-Disposition: inline
In-Reply-To: <20090128182305.21007.62781.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 10:23:05AM -0800, Tony Lindgren wrote:
> From: Juha Yrjola <juha.yrjola@solidboot.com>
> 
> At least on OMAP, sched_clock() requires the I/O maps to be initialized.
> Spinlock debugging invokes sched_clock() very early.

NAK.  This doesn't and can't work on every platform out there.  The
only viable fix is that sched_clock() must NOT be used early.

If the kernel is using sched_clock() early, that's a bug.
