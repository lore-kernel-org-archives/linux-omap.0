From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] twl6030: regulator: Remove vsel tables and use formula
 for calculation
Date: Fri, 23 Apr 2010 12:18:43 +0100
Message-ID: <20100423111843.GB27232@rakim.wolfsonmicro.main>
References: <1271926112-7700-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40205 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754848Ab0DWLSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Apr 2010 07:18:45 -0400
Content-Disposition: inline
In-Reply-To: <1271926112-7700-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, Apr 22, 2010 at 02:18:32PM +0530, Rajendra Nayak wrote:
> All twl6030 regulators can be programmed from 1.0v to 3.3v
> with 100mV steps.
> The below formula can be used to calculate the vsel values
> to be programmed in the VREG_VOLTAGE registers.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
