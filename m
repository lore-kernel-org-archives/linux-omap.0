From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Wed, 19 Jun 2013 09:26:33 +0100
Message-ID: <20130619082633.GB22998@laptop>
References: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:38291 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab3FSI0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 04:26:39 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so3015634eak.8
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 01:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, gg@slimlogic.co.uk

On Mon, 17 Jun 2013, J Keerthy wrote:

> Remove code which is not necessary for a device tree boot.

So we're exclusively DT now right?

> Boot tested on OMAP5-UEVM board.
>=20
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c |  106 ----------------------------------------=
----------
>  1 files changed, 0 insertions(+), 106 deletions(-)

If that's the case, applied with all Acks, thanks.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
