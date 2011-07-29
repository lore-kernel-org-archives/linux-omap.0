From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 2/4] regulator: omap smps regulator driver
Date: Fri, 29 Jul 2011 10:48:54 +0100
Message-ID: <20110729094853.GC13218@opensource.wolfsonmicro.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
 <1311853739-18984-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53590 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756088Ab1G2Jsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 05:48:55 -0400
Content-Disposition: inline
In-Reply-To: <1311853739-18984-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

On Thu, Jul 28, 2011 at 02:48:57PM +0300, Tero Kristo wrote:
> OMAP SMPS regulator driver provides access to OMAP voltage processor
> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> layer for the actual voltage regulation operations.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
