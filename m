From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for all MX
 postdividers
Date: Sat, 12 Feb 2011 18:10:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121809360.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com> <1297329400-5936-7-git-send-email-rnayak@ti.com> <1297329400-5936-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49517 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1BMBKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 20:10:51 -0500
In-Reply-To: <1297329400-5936-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> Enable hardware gate control for all dpll MX and X2 postdividers.
> This requires the allow_idle/deny_idle functions to be
> populated for all clock nodes (mx/x2 post dividers) in
> clkops.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39 in the 'clk_autoidle_a_2.6.39' branch.  Has the 
OMAP4 clock data autogenerator script been updated?


- Paul
