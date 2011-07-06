From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 05/13] OMAP2+: hwmod: Replace clkdm access from main_clk
 using hwmod attribute
Date: Wed, 6 Jul 2011 17:27:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107061726480.31498@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-6-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35968 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1GFX12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 19:27:28 -0400
In-Reply-To: <1309554558-19819-6-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Since the clkdm is now part of the omap_hwmod structure, there is no need
> to retrieve it from the main_clock or interface clock.
> The code can be simplified a little bit with a direct access.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

this won't work on OMAP2/3, so, dropping.


- Paul
