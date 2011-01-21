From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] omap3: nand: bch ecc support added
Date: Fri, 21 Jan 2011 13:41:53 +0530
Message-ID: <AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41085 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1AUIPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 03:15:20 -0500
Received: by wyb28 with SMTP id 28so1535648wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 00:15:19 -0800 (PST)
In-Reply-To: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Ghorai,

<snip>

> =A0#ifdef CONFIG_MTD_PARTITIONS
> diff --git a/drivers/mtd/nand/omap_bch_decoder.c b/drivers/mtd/nand/o=
map_bch_decoder.c
> new file mode 100644
> index 0000000..da42bda
> --- /dev/null
> +++ b/drivers/mtd/nand/omap_bch_decoder.c
> @@ -0,0 +1,393 @@
> +/*
> + * drivers/mtd/nand/omap_omap_bch_decoder.c
> + *
> + * Whole BCH ECC Decoder (Post hardware generated syndrome decoding)
> + *
> + * Copyright (c) 2007 Texas Instruments
> + *
> + * Author: Sukumar Ghorai <s-ghorai@ti.com
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Michael Fillinger <m-fillinger@ti.=
com>

Vimal was the original author who has created this file
[No change in file name/directory hierarchy].
It's not fair to remove Vimal's author and add your's.

Instead you should have kept his name and added your's.

<snip>

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
