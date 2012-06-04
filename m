From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 11/24] ARM: omap: clk: list all clk_hw_omap clks to
 enable/disable autoidle
Date: Sun, 3 Jun 2012 22:44:18 -0700
Message-ID: <20120604054417.GU12766@atomide.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
 <1338552485-31325-12-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17501 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2FDFoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 01:44:24 -0400
Content-Disposition: inline
In-Reply-To: <1338552485-31325-12-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120601 05:12]:
> @@ -359,6 +391,8 @@ const struct clk_hw_omap_ops clkhwops_wait = {
>  	.find_idlest	= omap2_clk_dflt_find_idlest,
>  	.find_companion	= omap2_clk_dflt_find_companion,
>  };
> +late_initcall(omap2_clk_enable_autoidle_all);

With -rc1, the SoC specific late_initcalls need to be called from
*_init_late that are in mach-omap2/io.c for omap2+.

Regards,

Tony
