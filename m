From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Tue, 4 Jan 2011 15:25:47 -0800
Message-ID: <20110104232547.GP7771@atomide.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
 <20110104015008.GX7771@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18026 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1ADXZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 18:25:55 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Pedanekar, Hemant" <hemantp@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Paul Walmsley <paul@pwsan.com> [110104 09:48]:
> On Tue, 4 Jan 2011, Pedanekar, Hemant wrote:
> 
> > Looking at above, it seems another config option like 
> > CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.
> 
> We already have CONFIG_ARCH_OMAP3430, CONFIG_ARCH_OMAP2430, and 
> CONFIG_ARCH_OMAP2420.  I guess at some point those need to be renamed to 
> CONFIG_SOC_*.

Yes that's what I was thinking too. Keep CONFIG_ARCH_OMAP2, 3, and 4,
and rename CONFIG_ARCH_OMAP3430 etc to CONFIG_SO_COMAP3430 and so on.

Regards,

Tony
