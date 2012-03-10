From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: REGRESSION: omap3 fails to boot
Date: Sat, 10 Mar 2012 19:20:22 +0000
Message-ID: <20120310192022.GB22875@n2100.arm.linux.org.uk>
References: <20120310180822.GA22875@n2100.arm.linux.org.uk> <CAK=WgbaAaUNr8uFU1bTcOMS1nbi_uN=Mw0=mm5rsQv2at8TUpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40228 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2CJTUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Mar 2012 14:20:34 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbaAaUNr8uFU1bTcOMS1nbi_uN=Mw0=mm5rsQv2at8TUpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org, arm@kernel.org

On Sat, Mar 10, 2012 at 08:31:50PM +0200, Ohad Ben-Cohen wrote:
> On Sat, Mar 10, 2012 at 8:08 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Seems to be that the OMAP mailbox stuff is buggered:
> 
> Can you please recheck with the following commit (already in mainline):
> 
> commit 134d12fae0bb8f3d60dc7440a9e1950bb5427167
> Author: Ohad Ben-Cohen <ohad@wizery.com>
> Date:   Sun Mar 4 12:01:11 2012 +0200
> 
>     ARM: OMAP: fix iommu, not mailbox
> 
>     For some weird (freudian?) reason, commit 435792d "ARM: OMAP: make
>     iommu subsys_initcall to fix builtin omap3isp" unintentionally changed
>     the mailbox's initcall instead of the iommu's.
> 
>     Fix that.
> 
>     Reported-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
>     Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>     Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>     Cc: Joerg Roedel <Joerg.Roedel@amd.com>
>     Cc: Tony Lindgren <tony@atomide.com>
>     Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

Why isn't this copied to the stable folk?  The commit which breaks this
was copied there, so that's going to break stable kernels.
