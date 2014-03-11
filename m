From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: Fix accessibility of some twl4030 audio
 registers
Date: Tue, 11 Mar 2014 06:51:33 +0000
Message-ID: <20140311065133.GD2839@lee--X1>
References: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:64982 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbaCKGvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2014 02:51:38 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so9662985wes.11
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2014 23:51:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomas Novotny <tomas@novotny.cz>
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com

> There are some unused registers in twl4030 at I2C address 0x49 and fu=
nction
> twl4030_49_nop_reg() is used to check accessibility of that registers=
=2E These
> registers are written in decimal format but the values are correct in
> hexadecimal format. (It can be checked few lines above the patched co=
de -
> these registers are marked as unused there.)
>=20
> As a consequence three registers of audio submodule are treated as
> inaccessible (preamplifier carkit right and both handsfree registers)=
=2E
>=20
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  drivers/mfd/twl-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

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
