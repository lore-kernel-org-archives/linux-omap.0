From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH v2 2/6] TI816X: clock: Add clock data
Date: Wed, 5 Oct 2011 11:42:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110051139410.4611@utopia.booyaka.com>
References: <1314119609-22882-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934662Ab1JERmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:42:46 -0400
In-Reply-To: <1314119609-22882-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Hi

On Tue, 23 Aug 2011, Hemant Pedanekar wrote:

> This patch adds data for various clocks present in TI816X.
> 
> Note that this data is not automatically generated and not all clocks are
> covered currently.

just a quick comment on this one, as I look it over.  This patch has some 
whitespace problems.  For example:

> +static struct clk tptc3_ick = {
> +	.name           = "tptc3_ick",
> +	.parent         = &sysclk4_ck,
> +	.ops            = &clkops_omap2_dflt,
> +	.enable_reg	= TI816X_CM_ALWON_TPTC3_CLKCTRL,
> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
> +	.clkdm_name	= "alwon_l3_fast_clkdm",
> +	.recalc         = &followparent_recalc,
> +};

The whitespace between the field names and the equal signs should be tabs, 
not spaces.  I realize that this is difficult to see with some editors, 
and that checkpatch.pl does not catch this (maybe it's time to send a 
checkpatch patch).  What I use here is show-wspace.el with emacs.  
show-wspace.pl is available from:

    http://www.emacswiki.org/cgi-bin/wiki/show-wspace.el


- Paul
