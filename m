From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Sat, 12 Feb 2011 17:28:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53723 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1BMA2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 19:28:19 -0500
In-Reply-To: <1297329400-5936-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> All OMAP3/4 dpll's support hardware level autogating.
> Populate allow_idle/deny_idle function pointers for all
> DPLL's in clkops.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39.  Two questions though.  Was the OMAP4 
autogeneration script updated?  Also, any technical reason why you didn't 
add the OMAP2 DPLL?


- Paul
