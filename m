From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
Date: Thu, 13 Mar 2014 11:27:11 -0700
Message-ID: <7hy50ekl8g.fsf@paris.lan>
References: <1394660600-3771-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63965 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaCMS1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 14:27:13 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so1490571pab.20
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2014 11:27:13 -0700 (PDT)
In-Reply-To: <1394660600-3771-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 12 Mar 2014 16:43:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Santosh <santosh.shilimkar@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
> CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
> failure complaining about the following:
> arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
> :(.text+0x8a70): undefined reference to `pm44xx_errata'
>
> Fixes: c962184 (ARM: OMAP4: PM: add errata support)
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
