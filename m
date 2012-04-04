From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_*_MASK bit
 definitions (fwd)
Date: Wed, 4 Apr 2012 10:04:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204041003160.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51028 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab2DDQEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 12:04:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi

vger is rejecting any mails with 'XXX' in the subject line, so this is 
just for the l-o record.  Hopefully the patch made it across the 
linux-arm-kernel list.


- Paul

---------- Forwarded message ----------
Date: Wed, 4 Apr 2012 09:53:23 -0600 (MDT)
From: Paul Walmsley <paul@pwsan.com>
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    tony@atomide.com, b-cousson@ti.com, khilman@ti.com, thara@ti.com
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit
    definitions

On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:

> In the SYSC_TYPE1_XXX_MASK configuration, SYSC_XXX_SHIFT macro
> is used which is not defined anywhere in the kernel.
> Until now the build was going through successfully, since it
> is not being used anywhere in kernel.
> 
> This bug got introduced by the commit
> 358f0e630d5409ab3837b86db3595560eae773b6 ("OMAP3: hwmod: support
> to specify the offset position of various SYSCONFIG register bits.")
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks, queued for 3.4-rc.

- Paul
