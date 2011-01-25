From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Tue, 25 Jan 2011 11:28:36 -0800
Message-ID: <20110125192836.GP13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <AANLkTi=PqUBrrZwWbipXDNxoKrcX8MefZjdeaOrgPApV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34993 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1AYT3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 14:29:09 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=PqUBrrZwWbipXDNxoKrcX8MefZjdeaOrgPApV@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Poddar, Sourav <sourav.poddar@ti.com> [110125 07:45]:
> 
> Just FYI, I observed similar results on OMAP4 for these patches.
> For OMAP2420, OMAP2430 and OMAP3430 SDPs, you can add my boot
> Tested-by: Sourav Poddar<sourav.poddar@ti.com>

Thanks, just posted third patch to this thread that fixes things
for omap4, care to give that a try too?

Regards,

Tony
