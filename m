From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
	L1 entries
Date: Sun, 8 Aug 2010 12:35:50 +0100
Message-ID: <20100808113550.GB23623@n2100.arm.linux.org.uk>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44678 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab0HHLgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Aug 2010 07:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONACHED

Spelling.

> types so that at boot-up, we can map memories outside system memory
> at page level granularity

If you're only using MT_MEMORY_NONCACHED (it seems so from patch 4),
please only modify that entry.
