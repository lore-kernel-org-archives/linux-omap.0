From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for
 AM43XX
Date: Fri, 13 Jun 2014 19:40:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406131939180.340@utopia.booyaka.com>
References: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53851 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaFMTki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 15:40:38 -0400
In-Reply-To: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, 9 Jun 2014, Dave Gerlach wrote:

> am43xx reset register layout is more similar to am33xx than omap4 so
> use the am33xx functions for hwmod hardreset soc_ops rather than the
> currently used omap4 functions. Without this, assert_hardreset and
> deassert_hardreset will not work on am43xx.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Makes sense to me; queued for v3.16-rc.


- Paul
