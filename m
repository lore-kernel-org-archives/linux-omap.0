From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 03/11] DT: regulator: Helper routine to extract
 regulator_init_data
Date: Fri, 16 Sep 2011 09:58:56 +0100
Message-ID: <20110916085856.GC22062@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <20110915134427.GJ7988@opensource.wolfsonmicro.com>
 <4E72F7AB.3030801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50025 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754894Ab1IPI66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 04:58:58 -0400
Content-Disposition: inline
In-Reply-To: <4E72F7AB.3030801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Fri, Sep 16, 2011 at 12:45:55PM +0530, Rajendra Nayak wrote:
> On Thursday 15 September 2011 07:14 PM, Mark Brown wrote:
> >On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:

> >>+- apply-uV: apply uV constraint if min == max

> >This seems a bit Linux/runtime policy specific (especially the last
> >bit).

> So these bindings should be defined differently?

If at all.
