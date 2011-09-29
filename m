From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/6] OMAP4: Add missing clock divider for
 OCP_ABE_ICLK
Date: Wed, 28 Sep 2011 20:44:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109282042220.19233@utopia.booyaka.com>
References: <1316195249-14914-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43560 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab1I2CoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 22:44:23 -0400
In-Reply-To: <1316195249-14914-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, b-cousson@ti.com

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> The parent clock of the OCP_ABE_ICLK is the AESS_FCLK and the
> parent clock of the AESS_FCLK is the ABE_FCLK...
> 
> ABE_FCLK --> AESS_FCLK --> OCP_ABE_ICLK
> 
> The AESS_FCLK and OCP_ABE_ICLK clocks both have dividers which
> determine their operational frequency. However, the dividers for
> the AESS_FCLK and OCP_ABE_ICLK are controlled via a single bit,
> which is the CM1_ABE_AESS_CLKCTRL[24] bit. When this bit is set to
> 0, the AESS_FCLK divider is 1 and the OCP_ABE_ICLK divider is 2.
> Similarly, when this bit is set to 1, the AESS_FCLK divider is 2
> and the OCP_ABE_ICLK is 1.
> 
> The above relationship between the AESS_FCLK and OCP_ABE_ICLK
> dividers ensure that the OCP_ABE_ICLK clock is always half the
> frequency of the ABE_CLK...
> 
> OCP_ABE_ICLK = ABE_FCLK/2
> 
> The divider for the OCP_ABE_ICLK is currently missing so add a
> divider that will ensure the OCP_ABE_ICLK frequency is always half
> the ABE_FCLK frequency.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.2.


- Paul
