From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Tue, 17 Jul 2012 13:28:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207171326510.28834@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com> <WC20120712144308.86003F@terrafix.co.uk> <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com> <WC20120713105737.0900A2@terrafix.co.uk> <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
 <20120717004010.GA6612@animalcreek.com> <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com> <WC20120717100848.280191@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33397 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab2GQT2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 15:28:14 -0400
In-Reply-To: <WC20120717100848.280191@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

Hi Joe, Mark,

On Tue, 17 Jul 2012, Joe Woodward wrote:

> The patch you sent is basically in two halves:
>   - the writes to the registers
>   - the calling of omap3_iva_idle().
> 
> If I patch only the writes to the registers then suspend still fails.
> If I patch only the calling of omap3_iva_idle() then suspend works.
> If I patch both the writes to the registers and the calling of omap3_iva_idle() then suspend works.

Wow, that's unexpected.  Thanks very much for trying this.

Well Mark, I guess that's your answer.  Looks like the IVA is still 
running on that AM3703 chip.  I guess it's probably best to do both 
halves, anyway.


- Paul
