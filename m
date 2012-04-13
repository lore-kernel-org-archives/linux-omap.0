From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Fri, 13 Apr 2012 04:43:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204130440390.25832@utopia.booyaka.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2DMKnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 06:43:08 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On Fri, 13 Apr 2012, Hiremath, Vaibhav wrote:

> Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
> These patches have been reviewed and accepted in the list, only thing is
> they couldn't make it to upstream during v3.4 merge window.
> 
> I believe Tony is going to push them for v3.5 now.

Hmm, but if you modify the AM3517EVM board file to call 
am33xx_init_early(), won't that break the AM3517EVM board?
Wouldn't a separate board file be needed for the AM33xx?


- Paul
