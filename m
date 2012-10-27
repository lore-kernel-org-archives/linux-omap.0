From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 1/8] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Sat, 27 Oct 2012 03:00:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210270300010.27071@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com> <1350552010-28760-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41465 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934267Ab2J0DAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 23:00:21 -0400
In-Reply-To: <1350552010-28760-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

On Thu, 18 Oct 2012, Tero Kristo wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> OMAP4 has module specific context lost registers which makes it now
> possible to have module level context loss count, instead of relying
> on the powerdomain level context count.
> 
> Add 2 private hwmod api's to update/clear the hwmod/module specific
> context lost counters/register.
> 
> Update the module specific context_lost_counter and clear the hardware
> bits just after enabling the module.
> 
> omap_hwmod_get_context_loss_count() now returns the hwmod context loss
> count them on platforms where they exist (OMAP4), else fall back on
> the pwrdm level counters for older platforms.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: added function kerneldoc, fixed structure kerneldoc,
>  rearranged structure to avoid memory waste, marked fns as OMAP4-specific,
>  prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
>  and clear, merged patches]
> [t-kristo@ti.com: added support for arch specific hwmod ops, and changed
>  the no context offset indicator to USHRT_MAX]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [paul@pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
>  convert unsigned context lost counter to int to match the return type;
>  get rid of hwmod_ops in favor of the existing soc_ops mechanism]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Thanks, re-queued for 3.8.

- Paul
