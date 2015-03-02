From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: DRA7: hwmod_data: Fix hwmod data for pcie
Date: Mon, 2 Mar 2015 04:05:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503020404360.9987@utopia.booyaka.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbbCBEFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2015 23:05:11 -0500
In-Reply-To: <1424422274-27946-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@linaro.org>, tony@atomide.com, nsekhar@ti.com, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com

On Fri, 20 Feb 2015, Kishon Vijay Abraham I wrote:

> Fixed hwmod data for pcie by having the correct module mode offset.
> Previously this module mode offset was part of pcie PHY which was wrong.
> Now this module mode offset was moved to pcie hwmod and removed the hwmod data
> for pcie phy. While at that renamed pcie_hwmod to pciess_hwmod in order
> to match with the name given in TRM.
> 
> This helps to get rid of the following warning
> "omap_hwmod: pcie1: _wait_target_disable failed"
> 
> [Grygorii.Strashko@linaro.org: Found the issue that actually caused
>  "omap_hwmod: pcie1: _wait_target_disable failed"]
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks sent this for v4.0-rc fixes.  Unfortunately I don't have a DRA7xx 
board so can't test.


- Paul
