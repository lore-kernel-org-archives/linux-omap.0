From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: Set DSS pins in correct mux
 mode.
Date: Thu, 4 Jul 2013 04:47:15 -0700
Message-ID: <20130704114714.GB5523@atomide.com>
References: <1371659083-14536-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19362 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753258Ab3GDLrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 07:47:19 -0400
Content-Disposition: inline
In-Reply-To: <1371659083-14536-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130619 09:31]:
> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> 
> Platform code used to depend on bootloadres for correctly setting the mux
> pin modes. But bootloaders should only set the minimum required mux pins.
> So, DSS mux pins are not set in U-Boot anymore and video display is broken
> on IGEPv2 when booting with newer U-Boot versions.
> 
> Setup the DSS pin muxes to enable display functionality.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Tony,
> 
> Can you please take this until we have finished the OMAP3 migration to DT?
> 
> I think it falls under the critical fix category that you were talking about.

Thanks, yes I'll apply it into omap-for-v3.11/fixes. Other than DSS and the
pending pinctrl-single patches, we have off-idle working for omap3 with DT,
so there really are no reasons to not make omap3 DT only very soon.

Regards,

Tony
