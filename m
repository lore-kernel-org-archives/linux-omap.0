From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for
 dss_dss_clk
Date: Thu, 24 Oct 2013 15:13:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310241512480.6544@utopia.booyaka.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab3JXPNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 11:13:16 -0400
In-Reply-To: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, t-kristo@ti.com

On Wed, 9 Oct 2013, Tomi Valkeinen wrote:

> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
> be configured without the need to get the parent of the fclk.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.

- Paul
