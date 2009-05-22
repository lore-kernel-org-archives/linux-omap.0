From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when
	disabling interrupts, v2"
Date: Sat, 23 May 2009 00:22:06 +0100
Message-ID: <20090522232206.GA6999@n2100.arm.linux.org.uk>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com> <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com> <4A15E5D9.7090704@samsung.com> <87hbzd89xz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43665 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936AbZEVXWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 19:22:18 -0400
Content-Disposition: inline
In-Reply-To: <87hbzd89xz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, May 22, 2009 at 07:54:32AM -0700, Kevin Hilman wrote:
> But the implemenation of that should not hold up this revert because
> this patch breaks *all* wakeups since the PRCM interrupt itself is
> disabled in the suspend path.

That is not mentioned in the patch description (and it should be).
What this paragraph is saying is that this revert is most definitely
fixing a regression.

Any "fix" which causes other breakage is not a fix, and therefore
this revert needs to go in no matter what.
