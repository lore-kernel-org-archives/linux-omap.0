From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] twl6030: regulator: Configure STATE register
 instead of REMAP
Date: Wed, 17 Feb 2010 16:15:58 +0000
Message-ID: <20100217161558.GB13324@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <1266420255-4307-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49070 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751923Ab0BQQQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 11:16:00 -0500
Content-Disposition: inline
In-Reply-To: <1266420255-4307-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Feb 17, 2010 at 08:54:15PM +0530, Rajendra Nayak wrote:
> This is no REMAP register on twl6030, instead there is a STATE register
> to drive a resource to a given state.
> The state register can be used to specify what state the resource should
> enter when its associated with a GRP.
> Register Bit field description is as below. The patch programmes the
> corresponding STATE registers for all LDO's to turn ON when assocaited
> with GRP_P1.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
