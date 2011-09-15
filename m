From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 02/11] regulator: Fix error check in
 set_consumer_device_supply
Date: Thu, 15 Sep 2011 14:33:37 +0100
Message-ID: <20110915133337.GI7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50316 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933125Ab1IONdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:33:39 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:51:58PM +0530, Rajendra Nayak wrote:
> The parameters to set_consumer_device_supply() can be considered
> invalid (and hence it could return -EINVAL) if nether consumer_dev nor
> consumer_dev_name are passed, not when *both* are passed.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

No, passing both is a clear bug on the part of the caller - the two ways
of specifying the device are not supposed to be used together.
