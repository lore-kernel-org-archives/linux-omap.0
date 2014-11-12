From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7: fix DSS PLL clock mux registers
Date: Wed, 12 Nov 2014 07:24:01 -0800
Message-ID: <20141112152401.GF26481@atomide.com>
References: <1413190241-13527-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11755 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752377AbaKLPYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 10:24:40 -0500
Content-Disposition: inline
In-Reply-To: <1413190241-13527-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, paul@pwsan.com, Somnath Mukherjee <somnath@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [141013 01:52]:
> The clock nodes for DSS VIDEO1/2 and HDMI have wrong register addresses.
> This patch fixes the addresses so that they point to
> CM_CLKSEL_VIDEO1_PLL_SYS, CM_CLKSEL_VIDEO2_PLL_SYS and
> CM_CLKSEL_HDMI_PLL_SYS.
> 
> Reported-by: Somnath Mukherjee <somnath@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applying into omap-for-v3.19/fixes-not-urgent thanks.

Tony
