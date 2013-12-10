From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 08/15] mfd: menelaus: Pass menelaus_chip pointer to
 add/remove irq functions
Date: Tue, 10 Dec 2013 09:00:21 +0000
Message-ID: <20131210090021.GQ12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:52022 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab3LJJAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 04:00:25 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so3620857yhz.15
        for <linux-omap@vger.kernel.org>; Tue, 10 Dec 2013 01:00:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386606085-26838-8-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> Those functions are static and can receive a menelaus_chip pointer ve=
ry
> easily.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 57 ++++++++++++++++++++++++++--------------=
----------
>  1 file changed, 30 insertions(+), 27 deletions(-)

Same here. I think this should be done in one fell swoop.

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
