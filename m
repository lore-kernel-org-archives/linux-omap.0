From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/6] ARM: mm: cache-l2x0: Add base address argument to
 write_sec callback
Date: Fri, 27 Jun 2014 09:44:28 +0200
Message-ID: <CACRpkdaA2oDOTBcL=S2j5bUTSB7oaS8ZWN0Rnf9Pbwtf3fTKjQ@mail.gmail.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
	<1403703451-12233-2-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:60806 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaF0Hoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 03:44:32 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so5124667oag.7
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2014 00:44:28 -0700 (PDT)
In-Reply-To: <1403703451-12233-2-git-send-email-t.figa@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Daniel Drake <drake@endlessm.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Wed, Jun 25, 2014 at 3:37 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> For certain platforms (e.g. Exynos) it is necessary to read back some
> values from registers before they can be written (i.e. SMC calls that
> set multiple registers per call), so base address of L2C controller is
> needed for .write_sec operation. This patch adds base argument to
> .write_sec callback so that its implementation can also access registers
> directly.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

>  arch/arm/mach-ux500/cache-l2x0.c   | 3 ++-

In our case just changing the signature of the function I see so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
