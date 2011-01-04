From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Mon, 3 Jan 2011 17:50:08 -0800
Message-ID: <20110104015008.GX7771@atomide.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16943 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1ADBuN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 20:50:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hemant Pedanekar <hemantp@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

* Paul Walmsley <paul@pwsan.com> [110103 15:06]:
> Hello Hemant 
> 
> On Mon, 3 Jan 2011, Hemant Pedanekar wrote:
> 
> > This patch updates the common platform files with TI816X support. Also adds new
> > files for TI816X modules base addresseses and irq definitions.
> > 
> > The approach taken in this patch is to add TI816X as part of OMAP3 variant where
> > the cpu class is considered as OMAP34XX and the type is TI816X. This means, both
> > cpu_is_omap34xx() and cpu_is_ti816x() checks return success on TI816X.
> 
> Looks like you should add a CONFIG_ARCH_OMAPTI816X Kconfig option for this 
> chip.  I suspect that many handheld device manufacturers won't want to 
> include TI816X-specific code/data in their builds, and vice versa.

Please use CONFIG_SOC_OMAPTI816X instead, eventually we should use
CONFIG_ARCH_OMAPX only for something that requires different compiler
options.

Regards,

Tony
