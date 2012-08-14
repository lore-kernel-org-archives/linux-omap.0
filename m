From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: RFC: changing DMA slave configuration API
Date: Tue, 14 Aug 2012 12:55:16 +0200
Message-ID: <CACRpkdYxg5sXGhk5ZDNtACyrE7ZffpZA4RR1zJcbfkQv-fi=CA@mail.gmail.com>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
	<CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
	<20120610112217.GD11404@n2100.arm.linux.org.uk>
	<1339390249.1927.1623.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61049 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2HNKzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 06:55:17 -0400
Received: by vbbff1 with SMTP id ff1so182024vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 03:55:16 -0700 (PDT)
In-Reply-To: <1339390249.1927.1623.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, Barry Song <21cnbao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 11, 2012 at 6:50 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:

> Do we have any users of peripheral to peripheral slave dma?
> IIRC  that is not the case, or does anyone know of existence or plans
> for such a h/w?

The U300 (COH901318) device can do this.

The usecase is basically that the modem CPU sets up a PCM
stream on the high-speed serial link (called MSL) and the DMA
controller reads 16 bit words from this link and routes it directly
to a PCM sink on an I2S hardware.

Actually it runs in both directions during a voicecall, you can
probably see the gain in power and CPU unload this will gain
on a phone.

However this is all out-of-tree code and not that big deal as
it's a legacy platform.

Yours,
Linus Walleij
