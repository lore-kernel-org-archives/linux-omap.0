From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/4] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 2 Mar 2012 14:53:35 +0100
Message-ID: <20120302135335.GS9008@sortiz-mobl>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
 <1330421953-29517-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1171 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab2CBNqH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 08:46:07 -0500
Content-Disposition: inline
In-Reply-To: <1330421953-29517-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>

Hi,

On Tue, Feb 28, 2012 at 03:09:10PM +0530, Rajendra Nayak wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
> added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
> regulator voltages can only be controlled through the smartreflex
> voltage channel, thus the support for the voltage_get and set is
> minimal and requires external controller.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Mark, Liam, are you guys taking this one ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
