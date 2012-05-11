From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: OTG integration: fix compiler warning
Date: Fri, 11 May 2012 09:57:48 -0700
Message-ID: <20120511165748.GU21851@atomide.com>
References: <alpine.DEB.2.00.1205091637100.23869@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43210 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab2EKQ5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 12:57:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205091637100.23869@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120509 15:41]:
> 
> Tony reported the following compile warning after commit
> eeb3711b89d68e147e05e7b43a49ecc5009dc157 ("ARM: OMAP2+: clean up some
> cppcheck warnings"):
> 
> arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
> arch/arm/plat-omap/usb.c:40: warning: unused variable 'status'
> 
> This happens if CONFIG_ARCH_OMAP_OTG is set but
> CONFIG_USB_GADGET_OMAP, CONFIG_USB_OHCI_HCD,
> CONFIG_USB_OHCI_HCD_MODULE, and CONFIG_USB_OTG are all unset.
> 
> Fix by localizing the status variable to the blocks that use it.
> 
> Compile-tested only, with omap2plus_defconfig and omap2plus_defconfig
> with CONFIG_USB_OHCI_HCD and CONFIG_USB_OTG enabled.

Thanks applying into fixes-for-cleanup branch.

Tony
