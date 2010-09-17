From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] omap: Map only available sram memory
Date: Fri, 17 Sep 2010 11:15:31 +0100
Message-ID: <20100917101531.GB27467@n2100.arm.linux.org.uk>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35917 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0IQKPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:15:43 -0400
Content-Disposition: inline
In-Reply-To: <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 17, 2010 at 03:17:46PM +0530, Santosh Shilimkar wrote:
> Currently we map 1 MB section while setting up SRAM on OMAPs.
> The actual physcal OCM RAM available on OMAP SOCs is in order

physical

> of KBs. This patch maps only available sram and removes some
> non necessary cpu_is_xxx checks.
> 
> On the newer ARMs with speculation, this is dangerous and can
> result in untraceable aborts.

"this" should be expanded (otherwise it is unclear whether it refers to
the original code or the new code.)
