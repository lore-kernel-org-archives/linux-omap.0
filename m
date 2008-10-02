From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/10] OMAP clock updates for post 2.6.27
Date: Thu, 2 Oct 2008 21:17:15 +0100
Message-ID: <20081002201715.GC12718@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55205 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYJBUR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 16:17:26 -0400
Content-Disposition: inline
In-Reply-To: <20081002163508.15385.43247.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Oct 02, 2008 at 10:37:46AM -0600, Paul Walmsley wrote:
> This patch series updates the OMAP2/3 clock tree. Some patches are
> from Tony's previous omap2-upstream series, and were already posted to
> linux-arm-kernel and reviewed[1].  The remaining patches are mostly
> clockdomain updates.

Great.

> The series can be pulled from:
> 
>    git://git.pwsan.com/linux-2.6 omap-clock-upstream
> 
> The branch is based on rmk/devel, since powerdomain and clockdomain
> changes are not yet in mainline.

I assume then you haven't read the top commit on my devel branch, which
reads:

    DO NOT BASE YOUR TREE ON THE DEVEL BRANCH

    Merge branch 'master' into devel

The reason is that 'devel' is a convenience merge branch of currently
about 25 other sub-branches for people who want to get the entire lot
of changes.  As such, the merges found there are frequently discarded
and recreated.

If you want something more stable and omap related, that can be
arranged.
