From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 04/11] omap4: SDP: Pass regulator_init_data from DT
Date: Thu, 15 Sep 2011 16:16:07 -0600
Message-ID: <20110915221607.GM3523@ponder.secretlab.ca>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <20110915134618.GK7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:58031 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935114Ab1IOWQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 18:16:12 -0400
Received: by gwb17 with SMTP id 17so3792115gwb.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 15:16:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110915134618.GK7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 02:46:18PM +0100, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:52:00PM +0530, Rajendra Nayak wrote:
> 
> > +Required properties:
> > +- compatible: Must be "regulator","ti,twl-reg";
> 
> I'd expect listings for the specific chips too.
> 
> > +	xyz-regulator: regulator@0 {
> > +		compatible = "regulator","ti,twl-reg";
> > +		ti,reg-id = <37>; /* TWL6030_REG_VAUX1_6030 */
> 
> These magic numbers are *very* Linux specific, we should have a better
> way of specifying regulators - I'd off the top of my head expect that
> the compatible property would identify the regulator.

Yes, that is exactly what it should do.

g.
