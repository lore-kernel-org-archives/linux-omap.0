From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] regulator: twl: make 6030 regulators useable
Date: Sat, 2 Apr 2011 10:03:03 +0900
Message-ID: <20110402010301.GA25424@opensource.wolfsonmicro.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50528 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752091Ab1DBBCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 21:02:54 -0400
Content-Disposition: inline
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>

On Fri, Apr 01, 2011 at 10:22:41AM +0530, Nishanth Menon wrote:
> TWL6030 regulator dynamic operations such as those on vaux2 and vaux3
> were reported to be broken on platforms such as pandaboard(OMAP4).
> Digging deeper into the code, found that 6030 regulator support
> requires quiet a bit of fixes to make it useable. Major change w.r.t
> TWL4030 has been the introduction of CFG_STATE register in TWL6030
> which is needed to be used for regulator control compared to messages
> which were used in TWL4030.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
