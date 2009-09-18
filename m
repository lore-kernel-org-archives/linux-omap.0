From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/2 v2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Fri, 18 Sep 2009 12:51:04 +0100
Message-ID: <20090918115104.GC4075@flint.arm.linux.org.uk>
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com> <87hbvytich.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53814 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbZIRLv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 07:51:26 -0400
Content-Disposition: inline
In-Reply-To: <87hbvytich.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

On Sun, Aug 23, 2009 at 10:56:14PM +0300, Kevin Hilman wrote:
> This should not be FOURPORT, it should just be a number.  In this case,
> it should be 3 (the others start from zero.)
> 
> The Zoom2 one should then be changed to something >= 4.

No it should not.  There's an enum to control the numbering of these.
Use that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
