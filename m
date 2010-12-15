From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
Date: Wed, 15 Dec 2010 07:53:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012150750460.15971@utopia.booyaka.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com> <4D05D586.6090408@ti.com> <AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com> <alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
 <20101215085646.GA5222@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35520 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab0LOOxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 09:53:32 -0500
In-Reply-To: <20101215085646.GA5222@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 15 Dec 2010, Russell King - ARM Linux wrote:

> No it doesn't - this is not a valid reason to bugger about with drivers
> to make them non-standard.
> 
> omap_ioremap() can be improved to retain its re-use of static mappings
> by having some kind of tree structure or something like that - ioremap
> is after all not a performance critical path.  There's no need to start
> passing virtual addresses to drivers.

OK, that's the approach we'll take then, when or if that needs to happen.

Omar, please ignore my earlier post and just call ioremap() directly from 
your driver code.


- Paul

