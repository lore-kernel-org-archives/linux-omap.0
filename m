From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Wed, 18 Apr 2012 16:21:35 -0700
Message-ID: <20120418232135.GU21106@atomide.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204130440390.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22406 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab2DRXVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 19:21:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204130440390.25832@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Paul Walmsley <paul@pwsan.com> [120413 03:46]:
> Hi Vaibhav,
> 
> On Fri, 13 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
> > These patches have been reviewed and accepted in the list, only thing is
> > they couldn't make it to upstream during v3.4 merge window.
> > 
> > I believe Tony is going to push them for v3.5 now.
> 
> Hmm, but if you modify the AM3517EVM board file to call 
> am33xx_init_early(), won't that break the AM3517EVM board?
> Wouldn't a separate board file be needed for the AM33xx?

You can have multiple MACHINE_START entries in a board-*.c file
if that's what you're asking.

Regards,

Tony
