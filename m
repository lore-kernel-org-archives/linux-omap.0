From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] arm: omap: clock: fix compile warning
Date: Fri, 4 Mar 2011 14:32:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103041432160.10981@utopia.booyaka.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com> <1294918868-16263-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47249 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167Ab1CDVcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:32:25 -0500
In-Reply-To: <1294918868-16263-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, 13 Jan 2011, Felipe Balbi wrote:

> if building kernels without OMAP2 support, we
> will see a warning such as:
> 
> arch/arm/mach-omap2/io.c: In function 'omap2_init_common_infrastructure':
> arch/arm/mach-omap2/io.c:389:3: warning: statement with no effect
> arch/arm/mach-omap2/io.c:391:3: warning: statement with no effect
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Thanks, queued for 2.6.39.

- Paul
