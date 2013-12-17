From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 04/41] CLK: TI: Add DPLL clock support
Date: Tue, 17 Dec 2013 08:40:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170838530.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53980 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3LQIkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 03:40:21 -0500
In-Reply-To: <1385453182-24421-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> new file mode 100644
> index 0000000..921a409
> --- /dev/null
> +++ b/drivers/clk/ti/dpll.c
> @@ -0,0 +1,597 @@

...

> +/**
> + * of_ti_dpll_setup - Setup function for OMAP DPLL clocks
> + *
> + * @node: device node containing the DPLL info
> + * @ops: ops for the DPLL
> + * @ddt: DPLL data template to use
> + * @init_flags: flags for controlling init types
> + */

The kerneldoc-nano for this function isn't right.  The blank line
before the arguments should be removed.


- Paul
