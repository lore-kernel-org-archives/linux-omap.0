From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] Regulator: Creating TWL4030 specific file having
 supplies & init data
Date: Mon, 11 Jan 2010 11:18:29 +0000
Message-ID: <20100111111829.GD20717@rakim.wolfsonmicro.main>
References: <1262973463-32492-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51339 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752145Ab0AKLSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:18:30 -0500
Content-Disposition: inline
In-Reply-To: <1262973463-32492-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Jan 08, 2010 at 11:27:43PM +0530, Anuj Aggarwal wrote:
> A new file for TWL4030/TPS65950 is created which has common supplies
> and regulator init data structures. They will be referenced from the
> various board-evm files depending upon the EVM requirements.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c |  175 ++++++++++++++++++++++
>  1 files changed, 175 insertions(+), 0 deletions(-)

Shouldn't there be a header file as well?
