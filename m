From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4+: PRM: add support for passing status
 register/bit info to reset
Date: Fri, 8 May 2015 17:51:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505081751420.19833@utopia.booyaka.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com> <1430832785-1976-2-git-send-email-t-kristo@ti.com> <5548F43A.4020409@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45149 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbbEHRwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 13:52:00 -0400
In-Reply-To: <5548F43A.4020409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, d-gerlach@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 5 May 2015, Suman Anna wrote:

> On 05/05/2015 08:33 AM, Tero Kristo wrote:
> > AM43xx has slightly different reset register layout compared to OMAP4+,
> > with varying status bit shifts and status register offsets. Current
> > code assumes static offsets and identical status / reset control bit
> > shifts, which is wrong. This patch adds PRM core support for passing
> > the actual implementations from hwmod code. AM43xx mappings will be fixed
> > in subsequent patch.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Reported-by: Dave Gerlach <d-gerlach@ti.com>
> > Reported-by: Anna Suman <s-anna@ti.com>
> 
> Looks good to me, please correct the signature to
> Suman Anna <s-anna@ti.com> on this patch and next patch as well.

Fixed in the local patches here.


- Paul
