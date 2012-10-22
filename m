From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Mon, 22 Oct 2012 09:38:26 -0700
Message-ID: <20121022163825.GA4730@atomide.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39489 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079Ab2JVQia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 12:38:30 -0400
Content-Disposition: inline
In-Reply-To: <50857444.9080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121022 09:30]:
> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> > 
> > * 2430sdp: vfp_reload_hw oops during MMC initialization
> >   - Kernel attempts to save FP registers that don't exist; fix posted:
> >     - http://www.spinics.net/lists/arm-kernel/msg200646.html

Has that one been posted to RMK's patch system?

> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - due to a GPMC bug
> >   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
> 
> This is now addressed and I have verified it is booting on v3.7-rc2. The
> following patch address this boot problem ...
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3

That's in v3.7-rc2 already, is there some other problem too?

Regards,

Tony
