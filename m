From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP3 clock: fix 96MHz clocks, usbhost_120m_fclk
	enable
Date: Mon, 4 Aug 2008 11:13:44 +0300
Message-ID: <20080804081343.GB8885@atomide.com>
References: <20080717021112.21489.95137.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52493 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYHDINs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 04:13:48 -0400
Content-Disposition: inline
In-Reply-To: <20080717021112.21489.95137.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, vikram.pandita@ti.com

* Paul Walmsley <paul@pwsan.com> [080717 05:15]:
> This series fixes a few bugs in the OMAP3 clock tree.  The most noticeable
> difference is that the "Clock usbhost_48m_fck didn't enable in 100000 tries"
> no longer appears during boot.

Pushing these two today.

Tony

> 
> 
> ---
> 
>    text    data     bss     dec     hex filename
> 3391587  157104  107136 3655827  37c893 vmlinux.3430sdp.orig
> 3391683  157104  107136 3655923  37c8f3 vmlinux.3430sdp.new
> 
>  arch/arm/mach-omap2/clock.c           |   63 ++++++++++++++++++---------------
>  arch/arm/mach-omap2/clock34xx.h       |   60 ++++++++++++++++++++-----------
>  arch/arm/mach-omap2/cm-regbits-34xx.h |   10 ++++-
>  3 files changed, 80 insertions(+), 53 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
