From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Wed, 19 Jun 2013 09:51:50 +0100
Message-ID: <20130619085150.GD22998@laptop>
References: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
 <20130619082633.GB22998@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:54355 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933820Ab3FSIv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 04:51:56 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so4266721wes.12
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 01:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130619082633.GB22998@laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, gg@slimlogic.co.uk

On Wed, 19 Jun 2013, Lee Jones wrote:

> On Mon, 17 Jun 2013, J Keerthy wrote:
>=20
> > Remove code which is not necessary for a device tree boot.
>=20
> So we're exclusively DT now right?
>=20
> > Boot tested on OMAP5-UEVM board.
> >=20
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > ---
> >  drivers/mfd/palmas.c |  106 --------------------------------------=
------------
> >  1 files changed, 0 insertions(+), 106 deletions(-)
>=20
> If that's the case, applied with all Acks, thanks.

Ah, it looks like Sam must have already applied this.

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
