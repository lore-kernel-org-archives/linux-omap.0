From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Wayoperationcan
	cause data corruption
Date: Mon, 7 Mar 2011 19:10:00 +0000
Message-ID: <20110307191000.GC2400@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com> <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com> <20110227120021.GA15314@n2100.arm.linux.org.uk> <20110228101351.GA30781@n2100.arm.linux.org.uk> <69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com> <000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com> <491849bc08797fc8c4d0def52dd6308a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36611 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1CGTKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 14:10:18 -0500
Content-Disposition: inline
In-Reply-To: <491849bc08797fc8c4d0def52dd6308a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, tony@atomide.com, Catalin Marinas <Catalin.Marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Mar 07, 2011 at 05:55:22PM +0530, Santosh Shilimkar wrote:
> Below is the updated version. Also attached.
> 
> Russell,
> Do you want me to push this to patch system or you can
> apply this one?

Patch system please.
