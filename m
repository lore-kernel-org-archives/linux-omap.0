From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] gpio/omap: implement irq mask/disable with proper semantic.
Date: Fri, 26 Apr 2013 09:56:24 +0200
Message-ID: <CACRpkdaQMckZkzBKSRsLA6ng=ixAJtzFfw1aLwSD-bPsS5tS3g@mail.gmail.com>
References: <5167DFC8.8060202@ti.com>
	<1366399255-30245-1-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40887 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab3DZH4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 03:56:25 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so4611494iec.22
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 00:56:25 -0700 (PDT)
In-Reply-To: <1366399255-30245-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, daniel@zonque.org, Jon Hunter <jon-hunter@ti.com>

On Fri, Apr 19, 2013 at 9:20 PM, Andreas Fenkart
<andreas.fenkart@streamunlimited.com> wrote:

> When a gpio interrupt is masked, the gpio event will still be latched in
> the interrupt status register so when you unmask it later you may get an
> interrupt straight away. However, if the interrupt is disabled then gpio
> events occurring will not be latched/stored.
>
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Have to defer this to the next development cycle as no consensus
seem to have been reached with the maintainers of this driver.
Keep going.

Thanks,
Linus Walleij
