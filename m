From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 4/9] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
Date: Mon, 10 Mar 2014 14:34:43 +0000
Message-ID: <20140310143443.GE15558@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48885 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbaCJOes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 10:34:48 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so123010wiv.7
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2014 07:34:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393510711-4697-5-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> Use a meaningful name for the reference clocks so that it indicates t=
he function.
>=20
> Update the OMAP4+ USB Host node as well to be in sync with the change=
s.
>=20
> CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |  6 ++++++
>  arch/arm/boot/dts/omap5.dtsi |  6 ++++++
>  drivers/mfd/omap-usb-host.c  | 12 ++++++------
>  3 files changed, 18 insertions(+), 6 deletions(-)

The code looks fine and I queried the name change semantics before and
was satisfied with your answer, so as long as this patch has been
tested and nothing is broken:
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
