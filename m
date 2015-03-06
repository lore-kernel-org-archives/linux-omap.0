From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: OMAP2+: first set of hwmod and PRCM fixes for
 v4.0-rc
Date: Fri, 6 Mar 2015 09:54:50 -0800
Message-ID: <20150306175450.GY13520@atomide.com>
References: <alpine.DEB.2.02.1503020402460.9987@utopia.booyaka.com>
 <alpine.DEB.2.02.1503020413320.9987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery4.ore.mailhop.org ([54.191.151.194]:54312 "EHLO
	pmta1.delivery4.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474AbbCFSAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 13:00:14 -0500
Received: from smtp6.ore.mailhop.org (172.31.36.112) by pmta1.delivery1.ore.mailhop.org id hv7lhk20r84c for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 17:59:53 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1503020413320.9987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150301 20:17]:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.0-rc/omap-fixes-a
> 
> for you to fetch changes up to 50f59d07e9822274a2e6034777eb4e90cfb30cfc:
> 
>   ARM: OMAP4+: PRM: fix omap4 version of prm_save_and_clear_irqen (2015-03-01 16:58:25 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: first set of hwmod and PRCM fixes for v4.0-rc
> 
> This series fixes the following bugs:
> 
> - a lockdep problem with the OMAP hwmod code;
> - incorrect PCIe hwmod data for the DRA7xx chips;
> - the clockdomain handling in the hardreset deassertion code,
>   preventing idle;
> - the use of an IRQ status register rather than an IRQ enable register
>   in the OMAP4 PRM code.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.0-rc/20150301165949/

Thanks pulling this into omap-for-v4.0/fixes, sorry for the delay
with this one.

Regards,

Tony
