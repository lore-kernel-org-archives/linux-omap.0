From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH RESEND] omap : nand : fix subpage ecc issue with
 prefetch
Date: Thu, 12 May 2011 15:56:00 +0300
Message-ID: <1305204960.14423.0.camel@localhost>
References: <1305128847-12987-1-git-send-email-kishore.kadiyala@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39500 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab1ELM7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 08:59:25 -0400
Received: by eyx24 with SMTP id 24so414204eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 05:59:24 -0700 (PDT)
In-Reply-To: <1305128847-12987-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, stable@kernel.org, Vimal Singh <vimal.newwork@gmail.com>

On Wed, 2011-05-11 at 21:17 +0530, Kishore Kadiyala wrote:
> When reading/writing a subpage (When HW ECC is not available/enabled)
> for number of bytes not aligned to 4, the mis-aligned bytes are handl=
ed
> first (by cpu copy method) before enabling the Prefetch engine to/fro=
m
> 'p'(start of buffer 'buf'). Then it reads/writes rest of the bytes wi=
th
> the help of Prefetch engine, if available, or again using cpu copy me=
thod.
> Currently, reading/writing of rest of bytes, is not done correctly si=
nce
> its trying to read/write again to/from begining of buffer 'buf',
> overwriting the mis-aligned bytes.
>=20
> Read & write using prefetch engine got broken in commit '2c01946c'.
> We never hit a scenario of not getting 'gpmc_prefetch_enable' call
> success. So, problem did not get caught up.
>=20
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> Cc: stable@kernel.org [2.6.35+]

Pushed to l2-mtd-2.6.git, thanks.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
