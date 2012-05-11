From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: USB: fix ocpi_enable compile problem on
 non-1610 builds
Date: Fri, 11 May 2012 09:53:07 -0700
Message-ID: <20120511165306.GT21851@atomide.com>
References: <alpine.DEB.2.00.1205101625360.32719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39709 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759925Ab2EKQxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 12:53:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205101625360.32719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

* Paul Walmsley <paul@pwsan.com> [120510 15:31]:
> 
> Janusz Krzysztofik reported the following build break on OMAP1 builds that
> don't include CONFIG_ARCH_OMAP16XX:
> 
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
> lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This was caused by commit d3645d39ad0ed9f09535065676ea0ba114f93cdf
> ("ARM: OMAP1: OHCI: use platform_data fn ptr to enable OCPI bus").
> Fix by declaring an empty ocpi_enable() on non-16XX builds, which
> should work until the OCPI code is moved out to drivers/.

Thanks applying into fixes-for-cleanup branch.

Tony
