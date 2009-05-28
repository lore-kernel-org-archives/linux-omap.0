From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/5] More omap header clean-up for the merge window
	after 2.6.30
Date: Thu, 28 May 2009 16:27:48 +0100
Message-ID: <20090528152748.GC20736@n2100.arm.linux.org.uk>
References: <20090514231820.19331.65419.stgit@localhost> <20090519172130.GC19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54148 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZE1P15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 11:27:57 -0400
Content-Disposition: inline
In-Reply-To: <20090519172130.GC19742@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, May 19, 2009 at 10:21:31AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090514 16:22]:
> > Hi,
> > 
> > This series removes defines that are included from hardware.h via
> > various processor specific headers. The series makes the defines
> > processor specific where possible so they don't trigger recompile
> > and cause blocks for multi-omap booting.
> > 
> > After this series, pretty much the only remaining problem code
> > is the clock24xx.h that should have clock registers set dynamically
> > for 2420 and 2430. This series just makes the problem defines
> > local to clock24xx.h.
> 
> If no comments, I'll add these to the omap for-next branch to wait
> for the merge window.

Apart from the first patch, no further comments.
