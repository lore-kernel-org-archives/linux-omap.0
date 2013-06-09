From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
Date: Sun, 9 Jun 2013 13:28:55 +0800
Message-ID: <CAN1soZxC0QLGrhm=ZZpny0kDBnyv9ikZaw7gS+aLmbtPpd0pKw@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
	<20130607205044.16513.27675.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:59076 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3FIF25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jun 2013 01:28:57 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so4608534eaj.25
        for <linux-omap@vger.kernel.org>; Sat, 08 Jun 2013 22:28:56 -0700 (PDT)
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Walleij Linus <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Sat, Jun 8, 2013 at 4:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> For wake-up events from deeper idle modes we need to check the
> configured padconf registers for the wake-up bit and then call
> the related interrupt handler.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/pinctrl/Makefile                          |    3
>  drivers/pinctrl/pinctrl-single-omap.c             |  287 +++++++++++++++++++++
>  include/linux/platform_data/pinctrl-single-omap.h |    4
>  3 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
>  create mode 100644 include/linux/platform_data/pinctrl-single-omap.h
>

The hardware behavior likes PXA3xx.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Regards
Haojian
