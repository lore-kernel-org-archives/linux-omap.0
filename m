From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
Date: Fri, 8 Jun 2012 10:50:40 +0200
Message-ID: <CACRpkdaoOzUD4BV3Hh=ZAOr6ZSE_04NwfJXFoKnadSbmz43JFw@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43849 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760643Ab2FHIul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 04:50:41 -0400
Received: by eeit10 with SMTP id t10so909169eei.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 01:50:40 -0700 (PDT)
In-Reply-To: <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Thu, Jun 7, 2012 at 1:08 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP SPI driver. =A0This supplements th=
e
> private DMA API implementation contained within this driver, and the
> driver can be independently switched at build time between using DMA
> engine and the private DMA API for the transmit and receive sides.
>
> Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This looks very good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
