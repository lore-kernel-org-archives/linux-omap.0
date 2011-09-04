From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/11] ARM: pm: no need to save/restore context ID
	register
Date: Sun, 4 Sep 2011 11:08:42 +0100
Message-ID: <20110904100842.GA6918@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk> <E1Qz6jT-00078d-LC@rmk-PC.arm.linux.org.uk> <4E6256BC.3080604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40801 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab1IDKIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 06:08:53 -0400
Content-Disposition: inline
In-Reply-To: <4E6256BC.3080604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Sep 03, 2011 at 10:03:00PM +0530, Santosh wrote:
> Typo which results in build error.
> Error: co-processor register expected -- `mcr p15,0,ip,c13,0,1'
>
> You can fold below fix.

Kevin already reported this, and I've already folded this fix in.  Thanks.
