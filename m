From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: fix the USB phy node
Date: Mon, 17 Jun 2013 15:54:37 +0200
Message-ID: <51BF151D.3010101@linutronix.de>
References: <1371475637-16951-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37366 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3FQNyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 09:54:40 -0400
In-Reply-To: <1371475637-16951-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>

On 06/17/2013 03:27 PM, Sebastian Andrzej Siewior wrote:
> index 6eec699..a12e9b0 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -128,7 +128,7 @@
>  };
> =20
>  &usbhsehci {
> -	phys =3D <0 &hsusb2_phy>;
> +	phys =3D <&hsusb2_phy 0>;
>  };
> =20
>  &twl_gpio {

Wait. Or does it mean that the first phy is deactivated and we add
phyhandle 0 (which is the root node) to skip it?

I assume that now since we don't have a cells property (like
#gpio-cells for the gpio lookup).

So ignore it please=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
