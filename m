From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed
 from board files
Date: Thu, 15 Sep 2011 14:32:36 +0100
Message-ID: <20110915133236.GH7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50303 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933125Ab1IONch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:32:37 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:51:57PM +0530, Rajendra Nayak wrote:
> The TWL driver seems to set the default .valid_modes_mask to
> (REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY) and .valid_ops_mask
> to (REGULATOR_CHANGE_VOLTAGE | REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS)
> for all the registered regulators.
> 
> There is no need for all the board files to pass this information
> additionally, when the driver already sets them by default.

"the driver"?  This sounds very buggy...
