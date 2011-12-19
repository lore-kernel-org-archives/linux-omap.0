From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
Date: Mon, 19 Dec 2011 13:03:21 +0100
Message-ID: <20111219120321.GM11800@sortiz-mobl>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30340 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab1LSL6t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 06:58:49 -0500
Content-Disposition: inline
In-Reply-To: <1323439361-1647-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Balaji T K <balajitk@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

Hi Benoit,

On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:
> Add initial device-tree support for twl familly chips.
> The current version is missing the regulator entries due
> to the lack of DT regulator bindings for the moment.
> Only the simple sub-modules that do not depend on
> platform_data information can be initialized properly.
> 
> Add documentation for the Texas Instruments TWL Integrated Chip.
Thanks, patch applied.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
