From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
Date: Mon, 16 Jul 2012 22:49:17 +0200
Message-ID: <CACRpkdYMzdjFXBMs6do-yqiBFV5ru28SftA5u+ZkP5KO+PhjCA@mail.gmail.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
	<87394xhocn.fsf@ti.com>
	<CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
	<87a9z4g9bi.fsf@ti.com>
	<CACRpkdZxUpQ=a-yQ8b4bnX3S9penPWkxJ+PG2Zi4i9YZibYRiw@mail.gmail.com>
	<87ipdnein1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62883 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab2GPUtS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 16:49:18 -0400
Received: by qadb17 with SMTP id b17so1859298qad.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 13:49:17 -0700 (PDT)
In-Reply-To: <87ipdnein1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Jul 16, 2012 at 7:10 PM, Kevin Hilman <khilman@ti.com> wrote:

> Subject: [PATCH] MAINTAINERS: add entry OMAP GPIO driver
>
> Since I've been maintaining this, making it official at the request of the
> GPIO maintainers.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Thank! Applied, but:

> +F:     drivers/gpio/gpio.omap.c

I replaced the period with a dash:
drivers/gpio/gpio-omap.c

Yours,
Linus Walleij
