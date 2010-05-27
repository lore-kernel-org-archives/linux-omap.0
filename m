From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
Date: Thu, 27 May 2010 23:56:20 +0530
Message-ID: <AANLkTikQFjfV2NOxtCUuxajqICpNt7CnN-YHoSdKTLT-@mail.gmail.com>
References: <s-ghorai@ti.com> <1274966647-32500-1-git-send-email-s-ghorai@ti.com>
	<1274966647-32500-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39187 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542Ab0E0S0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 14:26:41 -0400
Received: by pxi18 with SMTP id 18so149503pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 11:26:41 -0700 (PDT)
In-Reply-To: <1274966647-32500-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 6:54 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote=
:
[...]
> -static unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cs_map;
> +static unsigned =A0 =A0 =A0 =A0int gpmc_cs_map; =A0 =A0 =A0 =A0/* fl=
ag for cs which are initialized */

Tab should be after 'int', not before.

[...]
> @@ -456,13 +565,22 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> =A0/**
> =A0* gpmc_prefetch_reset - disables and stops the prefetch engine
> =A0*/
> -void gpmc_prefetch_reset(void)
> +int gpmc_prefetch_reset(int cs)
> =A0{
> + =A0 =A0 =A0 u32 config1;
> +
> + =A0 =A0 =A0 /* check if the same module/cs is trying to reset */
> + =A0 =A0 =A0 config1 =3D gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> + =A0 =A0 =A0 if (((config1 >> CS_NUM_SHIFT) & 0x7) !=3D cs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +

You really do not need this.
Prefetch has just one instance at a time and 'reset' will be call only
when driver has got access to prefetch (for either read or write
access), from the driver.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
