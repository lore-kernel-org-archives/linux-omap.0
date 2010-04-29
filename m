From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Fix 3630 mux errors
Date: Thu, 29 Apr 2010 11:25:12 -0700
Message-ID: <20100429182512.GN7225@atomide.com>
References: <1272526065-29683-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51818 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab0D3RGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:06:42 -0400
Content-Disposition: inline
In-Reply-To: <1272526065-29683-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Allen Pais <allen.pais@ti.com>, Paul Walmsley <paul@pwsan.com>

* Manjunatha GK <manjugk@ti.com> [100429 00:23]:
> From: Allen Pais <allen.pais@ti.com>
> 
> The omap3630 has more mux signals than 34xx. The additional
> pins exist in omap36xx_cbp_subset, but are not initialized
> as the superset is missing these offsets. This causes the
> following errors during the boot:

I have an earlier version of this queued up, will take a look
and see if they're the same:

https://patchwork.kernel.org/patch/87555/

Regards,

Tony
