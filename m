From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Mon, 19 Dec 2011 09:33:31 +0100
Message-ID: <20111219083331.GW11800@sortiz-mobl>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
 <1323444589-19940-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab1LSI27 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:28:59 -0500
Content-Disposition: inline
In-Reply-To: <1323444589-19940-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>

Hi Tero,

On Fri, Dec 09, 2011 at 05:29:48PM +0200, Tero Kristo wrote:
> This is needed for SMPS regulators, which use the OMAP voltage
> processor for voltage get/set functions instead of the normal I2C
> channel. For this purpose, regulator_init_data->driver_data contents
> are expanded, it is now a struct which contains function pointers
> for the set/get voltage operations, a data pointer for these, and
> the previously used features bitmask.
Looks better than the previous versions. For the MFD part:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Liam, I assume this is going through your tree ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
