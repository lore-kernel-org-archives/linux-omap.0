From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Fix softreset for modules with optional
 clocks
Date: Tue, 21 Sep 2010 18:25:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211825030.4677@utopia.booyaka.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com> <1285088279-425-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36680 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0IVAZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:25:33 -0400
In-Reply-To: <1285088279-425-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, p-basak2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> Some modules (like GPIO, DSS...) require optionals clock to be enabled
> in order to complete the sofreset properly.
> Add a HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to force all optional clocks
> to be enabled before reset. Disabled them once the reset is done.
> 
> TODO:
> For the moment it is very hard to understand from the HW spec, which
> optional clock is needed and which one is not. So the current approach
> will enable all the optional clocks.
> Paul proposed a much finer approach that will allow to tag only the needed
> clock in the optional clock table. This might be doable as soon as we have
> a clear understanding of these dependencies.
> 
> Reported-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, queued for 2.6.37 with the pr_debug() change.


- Paul
