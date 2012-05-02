From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix CM register bit masks
Date: Wed, 2 May 2012 01:33:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020133470.19695@utopia.booyaka.com>
References: <1335529405-14230-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43532 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2EBHd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 03:33:57 -0400
In-Reply-To: <1335529405-14230-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 27 Apr 2012, Rajendra Nayak wrote:

> The register bits for MPU_CLK_SRC and IVA2_CLK_SRC
> in CM_CLKSEL1_PLL register are 3 bits wide.
> Fix the MASK definition accordingly.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 3.5.

- Paul
