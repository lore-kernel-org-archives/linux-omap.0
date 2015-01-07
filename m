From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/23] ARM: OMAP2: CM: remove unused PLL functions
Date: Wed, 7 Jan 2015 11:06:43 -0800
Message-ID: <20150107190643.GC13010@atomide.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59273 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbAGTK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 14:10:27 -0500
Content-Disposition: inline
In-Reply-To: <1417103514-17027-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [141127 07:53]:
> omap2xxx_cm_get_pll_config and omap2xxx_cm_get_pll_status are not used
> for anything, so remove these.

I'm picking up this one to into omap-for-v3.20/cleanup.

Regards,

Tony
