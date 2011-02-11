From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] regulator: twl: add clk32kg to twl-regulator
Date: Fri, 11 Feb 2011 11:19:06 +0000
Message-ID: <20110211111906.GF7180@opensource.wolfsonmicro.com>
References: <1297343690-4557-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40678 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755915Ab1BKLSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 06:18:45 -0500
Content-Disposition: inline
In-Reply-To: <1297343690-4557-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: lrg@slimlogic.co.uk, sameo@linux.intel.com, linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Feb 10, 2011 at 06:44:50PM +0530, Balaji T K wrote:
> In OMAP4 Blaze and Panda, 32KHz clock to WLAN is supplied from Phoenix TWL6030.
> The 32KHz clock state (ON/OFF) is configured in CLK32KG_CFG_[GRP, TRANS, STATE]
> register. This follows the same register programming model as other regulators
> in TWL6030. So add CLK32KG as pseudo regulator.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Though I can see someone wanting an adaption to the clock API on top of
this at some point.
