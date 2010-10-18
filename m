From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: complete removal of
 machine_desc.io_pg_offst and .phys_io
Date: Mon, 18 Oct 2010 14:45:22 -0700
Message-ID: <20101018214522.GE13341@atomide.com>
References: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
 <20101018141230.GD12449@n2100.arm.linux.org.uk>
 <20101018142158.GG12449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61385 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab0JRVpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 17:45:35 -0400
Content-Disposition: inline
In-Reply-To: <20101018142158.GG12449@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anand Gadiyar <gadiyar@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101018 07:13]:
> On Mon, Oct 18, 2010 at 03:12:30PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 18, 2010 at 06:27:36PM +0530, Anand Gadiyar wrote:
> > > Commit 861bd81ee6 in linux-next as of 20101018 (arm: remove
> > > machine_desc.io_pg_offst and .phys_io) missed out on updating
> > > a few boards. This causes the build of omap2plus_defconfig
> > > to fail. Fix this.
> > 
> > Not quite true.  The patch merged into my tree eliminates io_pg_offst and
> > phys_io for everything that is in my tree.
> > 
> > For new board support code which isn't in my tree, there is a problem -
> > patches to it can't be applied to my tree.
> > 
> > However, applying these patches to the trees which have the new code in
> > won't have the other changes related to the removal of io_pg_offst, and
> > so the support code will subtly break until it's all merged together.
> > 
> > There's two solutions to this.  One is to wait merging new board code
> > until after this merge window.  The other is to ensure that new board
> > code is in _my_ tree before the io_pg_offst changes were submitted...
> 
> I'm going to drop the io_pg_offst patches for a couple of days.  If
> this new board support can be sorted out to come into my tree in the
> next 24 hours, then I'm sure we can get this fixed properly.
> 
> I don't think I can afford to hold the io_pg_offst patches for more
> than 48 hours though, so Wednesday evening they'll be merged whatever.

Go ahead, I'll patch up accordingly in the omap tree so it will all
merge nicely in for-next and for the merge window.

Regards,

Tony
