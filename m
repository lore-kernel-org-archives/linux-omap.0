From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 04/11] omap4: SDP: Pass regulator_init_data from DT
Date: Thu, 15 Sep 2011 14:46:18 +0100
Message-ID: <20110915134618.GK7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58366 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933238Ab1IONqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:46:20 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:52:00PM +0530, Rajendra Nayak wrote:

> +Required properties:
> +- compatible: Must be "regulator","ti,twl-reg";

I'd expect listings for the specific chips too.

> +	xyz-regulator: regulator@0 {
> +		compatible = "regulator","ti,twl-reg";
> +		ti,reg-id = <37>; /* TWL6030_REG_VAUX1_6030 */

These magic numbers are *very* Linux specific, we should have a better
way of specifying regulators - I'd off the top of my head expect that
the compatible property would identify the regulator.
