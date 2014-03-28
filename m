From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: L2 cache: use macro instead of const
	number
Date: Fri, 28 Mar 2014 10:49:54 +0000
Message-ID: <20140328104954.GC27282@n2100.arm.linux.org.uk>
References: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41160 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751721AbaC1KuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 06:50:16 -0400
Content-Disposition: inline
In-Reply-To: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 28, 2014 at 02:05:28PM +0530, Sekhar Nori wrote:
> From: Afzal Mohammed <afzal@ti.com>
> 
> Its better to use the available macro than 0x1.
> No functional change.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> This series applies to latest of linux-next/master

NAK.  See my L2 cache series posted on LAKML which completely removes
this code.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
