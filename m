From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] regulator: twl: adapt twl-regulator driver to dt
Date: Thu, 27 Oct 2011 09:55:02 +0100
Message-ID: <20111027085501.GA6641@opensource.wolfsonmicro.com>
References: <1319702674-16304-1-git-send-email-rnayak@ti.com> <1319702674-16304-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51128 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753726Ab1J0IzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Oct 2011 04:55:04 -0400
Content-Disposition: inline
In-Reply-To: <1319702674-16304-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Thu, Oct 27, 2011 at 01:34:32PM +0530, Rajendra Nayak wrote:

> +	select OF_REGULATOR if OF

We should probably just not have OF_REGULATOR or do the select from the
core, this is just going to end up being noisy.
