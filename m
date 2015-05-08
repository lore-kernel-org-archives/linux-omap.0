From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4+: PRM: add support for passing status
 register/bit info to reset
Date: Fri, 8 May 2015 17:48:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505081748360.19833@utopia.booyaka.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com> <1430832785-1976-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45077 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbbEHRsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 13:48:51 -0400
In-Reply-To: <1430832785-1976-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, d-gerlach@ti.com, s-anna@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 5 May 2015, Tero Kristo wrote:

> AM43xx has slightly different reset register layout compared to OMAP4+,
> with varying status bit shifts and status register offsets. Current
> code assumes static offsets and identical status / reset control bit
> shifts, which is wrong. This patch adds PRM core support for passing
> the actual implementations from hwmod code. AM43xx mappings will be fixed
> in subsequent patch.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Dave Gerlach <d-gerlach@ti.com>
> Reported-by: Anna Suman <s-anna@ti.com>

Thanks, queued for v4.1-rc fixes.


- Paul
