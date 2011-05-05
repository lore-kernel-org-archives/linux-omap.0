From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] omap : nand : fix subpage ecc issue with prefetch
Date: Thu, 05 May 2011 21:48:58 +0300
Message-ID: <1304621338.7222.55.camel@localhost>
References: <1304334638-2198-1-git-send-email-kishore.kadiyala@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49350 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab1EESwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 14:52:35 -0400
Received: by eyx24 with SMTP id 24so762111eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 11:52:34 -0700 (PDT)
In-Reply-To: <1304334638-2198-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, vimal.newwork@gmail.com, bdefaria@adeneo-embedded.com

On Mon, 2011-05-02 at 16:40 +0530, Kishore Kadiyala wrote:
> For prefetch engine, read and write  got broken in commit '2c01946c'.
> We never hit a scenario of not getting 'gpmc_prefetch_enable'
> call success.
> When reading/writing a subpage with a non divisible by 4 ecc number
> of bytes, the mis-aligned bytes gets handled first before enabling
> the Prefetch engine, then it reads/writes rest of the bytes.
>=20
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>

This needs a better commit message with more explanation and analysis o=
f
the problem and how it was fixed.This commit message is not very
understandable. And then it needs also:

Cc: stable@kernel.org [2.6.36+]

Right? And then we could send it upstream.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
