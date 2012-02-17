From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] ARM: OMAP: clock: cleanup CPUfreq leftovers
Date: Fri, 17 Feb 2012 16:40:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202171640120.859@utopia.booyaka.com>
References: <1329342415-28702-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49900 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab2BQXkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 18:40:43 -0500
In-Reply-To: <1329342415-28702-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Wed, 15 Feb 2012, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Thanks to Russell King for pointing out the parts I missed under
> plat-omap in the original version.
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, this is an updated version of the previous one after a different
> CPUfreq patch from Russell made me realize I missed the plat-omap pieces.

Thanks, queued for 3.4.


- Paul
