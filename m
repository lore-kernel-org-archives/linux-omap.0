From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/12] Update OMAP2/3 powerdomains, clockdomains
Date: Fri, 12 Sep 2008 15:33:50 -0700
Message-ID: <20080912223349.GI10675@atomide.com>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64978 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYILWdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 18:33:52 -0400
Content-Disposition: inline
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080910 09:51]:
> This second version adds two fixes: it removes the extraneous init
> from csi2_96m_fck, and associates virt_opp_clkdm with wkup_pwrdm.
> 
> ...
> 
> This series updates the in-kernel OMAP2/3 clockdomain and powerdomain
> structures:
> 
> - Split the placeholder clockdomain "wkup_clkdm" into "cm_clkdm" and
>   "prm_clkdm".  This more accurately reflects the hardware.
> 
> - Add powerdomains and clockdomains for DPLLs 1 through 5 on OMAP3.
> 
> - Associate every clock in OMAP2/3 clock tree with an appropriate
>   clockdomain.
> 
> Boot-tested on 2430SDP and 3430SDP.

Pushed these. Sounds like we need to queue up bunch of clock and
powerdomain patches for mainline.

Tony

> 
> ---
> 
> size:
>    text    data     bss     dec     hex filename
> 3441382  157936  105728 3705046  3888d6 vmlinux.3430sdp.orig
> 3441638  158440  105728 3705806  388bce vmlinux.3430sdp
> 
>  arch/arm/mach-omap2/clock.c                   |    8 +
>  arch/arm/mach-omap2/clock24xx.h               |   56 ++++++----
>  arch/arm/mach-omap2/clock34xx.h               |  140 ++++++++++++++++++-------
>  arch/arm/mach-omap2/clockdomains.h            |   65 +++++++++++-
>  arch/arm/mach-omap2/powerdomains.h            |    5 +
>  arch/arm/mach-omap2/powerdomains34xx.h        |   31 ++++++
>  arch/arm/plat-omap/include/mach/powerdomain.h |    4 -
>  7 files changed, 239 insertions(+), 70 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
