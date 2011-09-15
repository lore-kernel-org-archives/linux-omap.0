From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 09/11] DT: regulator: Helper to extract regulator
 node based on supply name
Date: Fri, 16 Sep 2011 00:03:25 +0100
Message-ID: <20110915230324.GD3218@opensource.wolfsonmicro.com>
References: <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
 <20110915135416.GN7988@opensource.wolfsonmicro.com>
 <20110915225035.GP3523@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42602 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935256Ab1IOXD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 19:03:29 -0400
Content-Disposition: inline
In-Reply-To: <20110915225035.GP3523@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rajendra Nayak <rnayak@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:50:35PM -0600, Grant Likely wrote:

> We've got two competing approaches here.  For reg and interrupts, the
> proposal on the table that we talked about at LPC is to do reg-names
> and interrupts-names so as to preserve the existing semantics of the
> reg and interrupts properties.  For gpios we're using the binding
> "<name>-gpios" for named gpio references.  There isn't the same
> pressure to preserve existing bindings in that case.  I'm okay with
> either approach, providing that "-regulator" is encoded into the name.

I think I prefer the latter but I'm probably not too fussed.

I'd rather use something like -supply for these just on the basis that
you don't always connect things to regulators (for example, speaker
supplies are generally attached direct to the battery).
