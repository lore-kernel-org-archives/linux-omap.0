From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ARM: OMAP1: USB: fix ocpi_enable compile problem on non-1610 builds
Date: Mon, 14 May 2012 15:51:46 +0200
Message-ID: <7431581.eQlfa7RL1e@vclass>
References: <alpine.DEB.2.00.1205101625360.32719@utopia.booyaka.com> <20120511165306.GT21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43228 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab2ENNwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 09:52:05 -0400
Received: by bkcji2 with SMTP id ji2so3830524bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 06:52:03 -0700 (PDT)
In-Reply-To: <20120511165306.GT21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 11 of May 2012 09:53:07 Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120510 15:31]:
> > 
> > Janusz Krzysztofik reported the following build break on OMAP1 builds that
> > don't include CONFIG_ARCH_OMAP16XX:
> > 
> >   LD      .tmp_vmlinux1
> > arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
> > lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > This was caused by commit d3645d39ad0ed9f09535065676ea0ba114f93cdf
> > ("ARM: OMAP1: OHCI: use platform_data fn ptr to enable OCPI bus").
> > Fix by declaring an empty ocpi_enable() on non-16XX builds, which
> > should work until the OCPI code is moved out to drivers/.
> 
> Thanks applying into fixes-for-cleanup branch.
> 
> Tony

FWIW, works with OMAP1510 only config on my Amstrad Delta.

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
