From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 09/15] mfd: menelaus: Pass menelaus_chip pointer to
 get/set voltage
Date: Tue, 10 Dec 2013 09:01:42 +0000
Message-ID: <20131210090142.GR12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-9-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:50238 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3LJJBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 04:01:47 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so3631748yha.31
        for <linux-omap@vger.kernel.org>; Tue, 10 Dec 2013 01:01:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386606085-26838-9-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> Those functions are static and can easily receive a menelaus_chip
> pointer argument.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 50 +++++++++++++++++++++++++++-------------=
----------
>  1 file changed, 27 insertions(+), 23 deletions(-)

I see a theme forming.

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
