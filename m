From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH 1/5] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Wed, 4 Mar 2009 16:52:15 +0200
Message-ID: <269694c00903040652p5c779d2eye87e592fb5404c27@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:45663 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbZCDOwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 09:52:18 -0500
Received: by ewy25 with SMTP id 25so2710500ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 06:52:15 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287B84DB5@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 3, 2009 at 2:00 AM, Guzman Lugo, Fernando <x0095840@ti.com>=
 wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Mon, 23 Feb 2009 10:04:27 -0600
> Subject: [PATCH] DSPBRIDGE: Remove SEEK_* redefinitions
>
> This patch removes the SEEK_* redefinitions in host_os.h
>
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/include/dspbridge/host_os.h | =C2=A0 =C2=A06=
 ------
> =C2=A01 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/ar=
m/plat-omap/include/dspbridge/host_os.h
> index ff49e0d..9245eea
> --- a/arch/arm/plat-omap/include/dspbridge/host_os.h
> +++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
> @@ -60,12 +60,6 @@
> =C2=A0#include <asm/cacheflush.h>
> =C2=A0#include <linux/dma-mapping.h>
>
> -/* =C2=A0----------------------------------- Macros */
> -
> -#define SEEK_SET =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0/*=
 Seek from beginning of file. =C2=A0*/
> -#define SEEK_CUR =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0/*=
 Seek from current position. =C2=A0*/
> -#define SEEK_END =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0/*=
 Seek from end of file. =C2=A0*/
> -
> =C2=A0/* TODO -- Remove, once BP defines them */
> =C2=A0#define INT_MAIL_MPU_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A026
> =C2=A0#define INT_DSP_MMU_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A028
> --
> 1.5.6.4
>

Hi Fernando,

I am not able to apply this as it contains some extra characters "=3D20=
"
Here is the location:

 #include <linux/dma-mapping.h>
=3D20
-/*  ----------------------------------- Macros */

 Can you check configuration which is used for generating these patches=
?

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
