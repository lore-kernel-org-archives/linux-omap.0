From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH/RFT 1/3] ARM: OMAP2+: powerdomain: allow pre/post transtion
 to be per pwrdm
Date: Wed, 25 Apr 2012 21:31:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204252130080.30642@utopia.booyaka.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com> <1335277420-29124-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57588 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2DZDbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 23:31:22 -0400
In-Reply-To: <1335277420-29124-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, 24 Apr 2012, Kevin Hilman wrote:

> Iteration over all power domains in the idle path is unnecessary since
> only power domains that are transitioning need to be accounted for.
> Also PRCM register accesses are known to be expensive, so the
> additional latency added to the idle path is signficiant.
> 
> In order allow the pre/post transitions to be isolated and called
> per-pwrdm, change the API so passing in a specific power domain will
> trigger the pre/post transtion accounting for only that specific power
> domain.  Passing NULL means iterating over all power domains as is
> current behavior.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Based on a quick glance, it looks good to me:

Acked-by: Paul Walmsley <paul@pwsan.com>

Want to queue this one?


- Paul
