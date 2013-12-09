From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] ARM: AM43xx: fix dpll init in bypass mode
Date: Mon, 9 Dec 2013 01:23:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312090121150.32309@utopia.booyaka.com>
References: <1386059629-1234-1-git-send-email-sathyap@ti.com> <1386059629-1234-3-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59304 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759563Ab3LIBX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 20:23:26 -0500
In-Reply-To: <1386059629-1234-3-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com

On Tue, 3 Dec 2013, Sathya Prakash M R wrote:

> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> On AM43xx, if a PLL is in bypass at kernel init, the code in
> omap2_get_dpll_rate() will not realize this and will try to calculate
> the clock rate using the multiplier and the divider, resulting in
> errors.
> 
> omap2_init_dpll_parent() has similar issue.
> 
> Add the missing soc_is_am43xx() check to make the code work on AM43xx.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Did you intend to add your Signed-off-by: here, as is the upstream 
practice when you're part of the patch submission path?

Please let me know ASAP so I can queue this for the -rc series.

- Paul
