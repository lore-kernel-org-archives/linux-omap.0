From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP3: hwmod: fix variant registration and
 remove SmartReflex from common list
Date: Thu, 6 Oct 2011 16:29:00 -0700
Message-ID: <20111006232900.GC6324@atomide.com>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
 <20111006223545.GB27281@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1110061723550.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50712 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab1JFX3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:29:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110061723550.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Abhilash K V <abhilash.kv@ti.com>, Chase Maupin <chase.maupin@ti.com>

* Paul Walmsley <paul@pwsan.com> [111006 15:50]:
> 
> Commit d6504acd2125984c61dce24727dd3842d0144015 ("OMAP2+: hwmod:
> remove OMAP_CHIP*") tests the inverse condition of what it should be
> testing for the return value from omap_hwmod_register().  This causes
> several IP blocks to not be registered on several OMAP3 family devices.
> 
> Fixing that bug also unmasked another bug, originally reported by
> Chase Maupin <chase.maupin@ti.com> and then subsequently by Abhilash K
> V <abhilash.kv@ti.com>, which caused SmartReflex IP blocks to be
> registered on SoCs that don't support them.
> 
> Thanks to Russell King - ARM Linux <linux@arm.linux.org.uk> for comments
> on a previous version of the patch.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Chase Maupin <chase.maupin@ti.com>
> Cc: Abhilash K V <abhilash.kv@ti.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> ---
> 
> This version incorporates some comments from RMK.

Thanks, updating in fixes-part2.

Tony
