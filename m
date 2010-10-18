From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap: complete removal of
	machine_desc.io_pg_offst and .phys_io
Date: Mon, 18 Oct 2010 15:12:30 +0100
Message-ID: <20101018141230.GD12449@n2100.arm.linux.org.uk>
References: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52663 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab0JROMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 10:12:46 -0400
Content-Disposition: inline
In-Reply-To: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>

On Mon, Oct 18, 2010 at 06:27:36PM +0530, Anand Gadiyar wrote:
> Commit 861bd81ee6 in linux-next as of 20101018 (arm: remove
> machine_desc.io_pg_offst and .phys_io) missed out on updating
> a few boards. This causes the build of omap2plus_defconfig
> to fail. Fix this.

Not quite true.  The patch merged into my tree eliminates io_pg_offst and
phys_io for everything that is in my tree.

For new board support code which isn't in my tree, there is a problem -
patches to it can't be applied to my tree.

However, applying these patches to the trees which have the new code in
won't have the other changes related to the removal of io_pg_offst, and
so the support code will subtly break until it's all merged together.

There's two solutions to this.  One is to wait merging new board code
until after this merge window.  The other is to ensure that new board
code is in _my_ tree before the io_pg_offst changes were submitted...
