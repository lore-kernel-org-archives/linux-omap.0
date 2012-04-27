From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/12] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
Date: Fri, 27 Apr 2012 20:57:54 +0200
Message-ID: <CACRpkdbC9GhwEs+qEt8-vurpbXJFtRcsgkg+S4Au16WG3RsKLg@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45808 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab2D0S5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 14:57:54 -0400
Received: by ghrr11 with SMTP id r11so639006ghr.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 11:57:54 -0700 (PDT)
In-Reply-To: <E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Mon, Apr 23, 2012 at 6:04 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Split the virtual slave channel DMA support from the sa11x0 driver so
> this code can be shared with other slave DMA engine drivers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I really like the direction of this thing.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
