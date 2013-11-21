From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
Date: Wed, 20 Nov 2013 17:45:56 -0800
Message-ID: <20131121014555.GL10317@atomide.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com>
 <20131120192209.GI10317@atomide.com>
 <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
 <20131121000533.GJ10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752146Ab3KUBp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 20:45:59 -0500
Content-Disposition: inline
In-Reply-To: <20131121000533.GJ10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Tony Lindgren <tony@atomide.com> [131120 16:06]:
> 
> They at least had interrupts listed looking at commit 3b9b10. Probably
> the thing to do for now is to revert those changes, and see if we can
> just remove the L3 entries from the .dtsi files.

Actually the patch I posted should be able to handle also the
ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3" property in omap4.dtsi,
but we're not currently parsing that as we only look at the children
and not the properties of the OCP bus. Should be fixable, will take a look
tomorrow if this approach makes sense to you.

Regards,

Tony
