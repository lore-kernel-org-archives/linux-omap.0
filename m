From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 0/3] MFD/GPIO: Add twl6040 GPO driver
Date: Wed, 19 Sep 2012 13:26:07 +0200
Message-ID: <20120919112607.GD8138@sortiz-mobl>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52793 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab2ISL0H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 07:26:07 -0400
Content-Disposition: inline
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Peter,

On Thu, Aug 16, 2012 at 03:13:12PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1:
> - Removed the ti,use-gpo property from DT bindings
> - Register the GPO driver if we booted with DT blob or in legacy if the pdata
>   for the GPO driver is present
> - DT binding Documentation update
> 
> The Documentation update has reference to the twl6040.dtsi file which will be
> created to hold the common/static properties for the twl6040.
> To avoid cross tree merge issues later I have only included the Documentation
> update to this series and I will send the actual .dtsi/.dts changes via
> linux-omap. If this is not a problem.
> 
> The dependencies for this series are in mainline and I think this series can
> go via GPIO if Samuel agrees with the changes.
> 
> Intro mail from v1:
> 
> The following series adds support for the GPO (General Purpose Output) on the
> twl6040/41 audio chip.
> The series has been tested on SDP4430, compile tested for x86_64 and x86_32 bit
> to be sure it does not introduce build breakage.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   mfd: twl6040: Fix GPO mask
>   mfd: twl6040: Add twl6040-gpio child
>   gpio: Add basic support for TWL6040 GPOs
All 3 patches applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
