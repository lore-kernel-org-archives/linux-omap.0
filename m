From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: voltage: fixup oscillator handling when
 CONFIG_PM=n
Date: Wed, 14 Nov 2012 17:31:54 -0800
Message-ID: <20121115013153.GF6801@atomide.com>
References: <1352941984-11828-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10137 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964820Ab2KOBb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 20:31:56 -0500
Content-Disposition: inline
In-Reply-To: <1352941984-11828-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [121114 17:15]:
> From: Kevin Hilman <khilman@ti.com>
> 
> commit 908b75e8 (ARM: OMAP: add support for oscillator setup) added a new
> API for oscillator setup, but is broken when CONFIG_PM=n.
> 
> The new functions have dummy definitions when CONFIG_PM=n, but also have
> full implementations available, which conflict.
> 
> To fix, wrap the PM implmentations in #ifdef CONFIG_PM.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> This applies to Tony's omap-for-v3.8/pm branch, which includes my
> for_3.8-pm-voltage tag where this bug was introduced.

Thanks for fixing this quickly. Applied to omap-for-v3.8/pm-part2
and pushed out.

Regards,

Tony
