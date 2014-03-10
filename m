From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 1/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
Date: Mon, 10 Mar 2014 14:14:39 +0000
Message-ID: <20140310141439.GB15558@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:41161 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbaCJOOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 10:14:44 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so88433wib.3
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2014 07:14:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393510711-4697-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Tero Kristo <t-kristo@ti.com>

> Not all revisions have all the clocks so get the necessary clocks
> based on hardware revision.
>=20
> This should avoid un-necessary clk_get failure messages that were
> observed earlier.
>=20
> Also remove the dummy USB host clocks from the OMAP3 clock data.
> These are no longer expected by the driver.
>=20
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Tero Kristo <t-kristo@ti.com>
> Acked-by: Mike Turquette <mturquette@linaro.org> [OMAP3 CLK data]
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c |  4 ----
>  drivers/clk/ti/clk-3xxx.c             |  4 ----
>  drivers/mfd/omap-usb-host.c           | 43 +++++++++++++++++++++++++=
+---------
>  3 files changed, 32 insertions(+), 19 deletions(-)

Patches starting to take shape. I know that I've reviewed this patch
before, so if you've fixed-up all my previous comments you can have my
Ack for the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
