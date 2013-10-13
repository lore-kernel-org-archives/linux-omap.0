From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 01/36] CLK: TI: Add DPLL clock support
Date: Sun, 13 Oct 2013 23:47:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310132345400.27397@utopia.booyaka.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com> <1381332668-962-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38273 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3JMXrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Oct 2013 19:47:07 -0400
In-Reply-To: <1381332668-962-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Wed, 9 Oct 2013, Tero Kristo wrote:

> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

By the way:

> +
> +	if (of_property_read_bool(node, "ti,low-power-stop"))
> +		dpll_mode |= 1 << DPLL_LOW_POWER_STOP;
> +
> +	if (of_property_read_bool(node, "ti,low-power-bypass"))
> +		dpll_mode |= 1 << DPLL_LOW_POWER_STOP;

This doesn't look right.  Could you please check it?


- Paul
