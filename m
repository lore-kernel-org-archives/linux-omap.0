From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to
	speed-up boot
Date: Mon, 24 Jan 2011 10:30:43 +0000
Message-ID: <20110124103043.GB18459@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51062 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1AXKaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 05:30:55 -0500
Content-Disposition: inline
In-Reply-To: <1295859080-15259-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linus.ml.walleij@gmail.com

On Mon, Jan 24, 2011 at 02:21:19PM +0530, Santosh Shilimkar wrote:
> On some architectures, secondary cores shares clock with primiary
> core and hence scale together. Hence secondary core lpj calibration
> is not necessary and can be skipped to save considerable time.
> 
> This can speed up the secondary cpu boot and hotplug cpu online
> paths.

I still point out that this will be a user visible change in /proc/cpuinfo.
