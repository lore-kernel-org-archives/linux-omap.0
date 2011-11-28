From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv7 1/7] regulator: twl: fix twl4030 support for smps
 regulators
Date: Mon, 28 Nov 2011 18:58:55 +0000
Message-ID: <20111128185854.GC1586@opensource.wolfsonmicro.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
 <1322492005-27741-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52665 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752843Ab1K1S65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 13:58:57 -0500
Content-Disposition: inline
In-Reply-To: <1322492005-27741-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Mon, Nov 28, 2011 at 04:53:19PM +0200, Tero Kristo wrote:
> SMPS regulator voltage control differs from the one of the LDO ones.
> Current TWL code was using LDO regulator ops for controlling the SMPS
> regulators, which fails. This was fixed fixed by adding separate
> regulator type which uses correct logic and calculations for the
> voltage levels.

Applied, thanks.
