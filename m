From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED
	instead of MT_DEVICE
Date: Fri, 17 Sep 2010 11:16:02 +0100
Message-ID: <20100917101602.GC27467@n2100.arm.linux.org.uk>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35920 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0IQKQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:16:11 -0400
Content-Disposition: inline
In-Reply-To: <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 17, 2010 at 03:17:47PM +0530, Santosh Shilimkar wrote:
> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
> 
> Since the section mapping limitation gets fixed with first
> patch in this series, the MT_MEMORY_NONCACHED can be used now.
> 
> Have not tested this, so somebody with Davinci hardware can
> try this out

Is this still true?
