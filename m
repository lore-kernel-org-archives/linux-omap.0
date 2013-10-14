From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: Add qspi data for am437x.
Date: Mon, 14 Oct 2013 19:34:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310141933130.22465@utopia.booyaka.com>
References: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43481 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3JNTeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 15:34:03 -0400
In-Reply-To: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, nsekhar@ti.com, afzal@ti.com

Hi

On Mon, 14 Oct 2013, Sourav Poddar wrote:

> Add hwmod data for qspi for AM437x.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM
> basic support and tero's DT clock series.

Could you please rebase this on top of George Cherian's patch:

"[PATCH] ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x."

?


- Paul
