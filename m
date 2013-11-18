From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC 11/23] mfd: omap-usb-host: raw read and write endian fix
Date: Mon, 18 Nov 2013 10:35:35 +0000
Message-ID: <20131118103535.GD13640@lee--X1>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-12-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60004 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab3KRKfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 05:35:41 -0500
Received: by mail-ob0-f176.google.com with SMTP id wp4so6640578obc.7
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 02:35:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384560086-11994-12-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: linux-omap@vger.kernel.org, linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org

On Sat, 16 Nov 2013, Taras Kondratiuk wrote:

> From: Victor Kamensky <victor.kamensky@linaro.org>
>=20
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
>=20
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
>=20
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
>  drivers/mfd/omap-usb-host.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

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
