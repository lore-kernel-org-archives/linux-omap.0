From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 11:06:09 +0000
Message-ID: <20110124110609.GJ16202@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50766 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1AXLGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 06:06:50 -0500
Content-Disposition: inline
In-Reply-To: <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> In CPU low power state, local timer looses its register context. This
> patch adds context save restore hooks which can be used by platforms
> appropriately.

I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the generic
timer stuff wouldn't rely on it being kept alive?

Hmm, it looks like we bypass the clockevents code by only setting the
TWD load value at initialization time, not when we switch to periodic
mode.  We really ought to rewrite it whenever we switch back to periodic
mode.

I suspect fixing that means you won't need this save/restore support.
