From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: optimise interrupt service routine
Date: Wed, 10 Apr 2013 21:37:02 +0200
Message-ID: <CACRpkdZ46vq6GOtS31DYSVZj44GawxT-PabqRr=0nmam6kBsTQ@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
	<1365106576-31816-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53834 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DJThE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 15:37:04 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so749395iec.22
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 12:37:03 -0700 (PDT)
In-Reply-To: <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> The OMAP GPIO interrupt service routine is checking each bit in the
> GPIO interrupt status register to see which bits are set. It is not
> efficient to check every bit especially if only a few bits are set.
> Therefore, instead of checking every bit use the __ffs() function,
> which returns the location of the first set bit, to find all the set
> bits.
>
> This optimisation was suggested-by and developed in collaboration
> with Felipe Balbi.
>
> Cc: Felipe Balbi <balbi@ti.com>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Patch applied with Felipe's Reviewed-by tag.

Thanks,
Linus Walleij
