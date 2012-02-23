From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 3/7] MFD: twl-core: regulator configuration for twl6030
 V1V8, V2V1 SMPS
Date: Thu, 23 Feb 2012 16:22:09 +0100
Message-ID: <20120223152209.GA24377@sortiz-mobl>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4449 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010Ab2BWPWd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 10:22:33 -0500
Content-Disposition: inline
In-Reply-To: <1328868316-24749-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Peter,

On Fri, Feb 10, 2012 at 12:05:12PM +0200, Peter Ujfalusi wrote:
> To be able to attach consumers to these supplies from board
> files we need to have regulator_init_data for them.
If I understand correctly, this should also go through Liam's tree. If that's
so, please add my:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
