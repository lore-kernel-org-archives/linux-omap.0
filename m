From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
Date: Mon, 27 Aug 2012 15:43:04 -0700
Message-ID: <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
References: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:59250 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080Ab2H0WnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 18:43:25 -0400
Received: by iamm10 with SMTP id m10so8228833iam.15
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 15:43:24 -0700 (PDT)
In-Reply-To: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 27, 2012 at 3:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Currently, omap2_sync32k_clocksource_init() function initializes the 32K
> timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
> setting.
> Fix this by providing a default implementation for
> !CONFIG_OMAP_32K_TIMER case.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
