From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
Date: Thu, 24 Oct 2013 15:13:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310241513180.6544@utopia.booyaka.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com> <1381324359-28825-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45599 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3JXPN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 11:13:29 -0400
In-Reply-To: <1381324359-28825-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, t-kristo@ti.com

On Wed, 9 Oct 2013, Tomi Valkeinen wrote:

> Set CLK_SET_RATE_PARENT flag for dss1_alwon_fck_3430es2,
> dss1_alwon_fck_3430es1 and dpll4_m4x2_ck so that the DSS's fclk can be
> configured without the need to get the parent's parent of the fclk.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.

- Paul
