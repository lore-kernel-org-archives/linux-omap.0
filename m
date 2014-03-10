From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 2/9] mfd: omap-usb-host: Always fail on clk_get() error
Date: Mon, 10 Mar 2014 14:17:54 +0000
Message-ID: <20140310141754.GC15558@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38188 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbaCJOR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 10:17:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so87130wiw.0
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2014 07:17:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393510711-4697-3-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> Be more strict and always fail on clk_get() error.
>=20
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 62 +++++++++++++++++++++++++++++------=
----------
>  1 file changed, 40 insertions(+), 22 deletions(-)

I like to principle of the patch assuming that the devices would be
useless without their clocks.

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
