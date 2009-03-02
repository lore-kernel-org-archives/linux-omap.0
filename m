From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [OMAPZOOM][PATCH] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Mon, 2 Mar 2009 14:10:25 +0200
Message-ID: <269694c00903020410s7e1d0456td6bebba791bb50cb@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602854E3E50@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:50735 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbZCBMK2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 07:10:28 -0500
Received: by ewy25 with SMTP id 25so1998343ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 04:10:25 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602854E3E50@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Lugo,

On Mon, Feb 23, 2009 at 7:53 PM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Mon, 23 Feb 2009 10:04:27 -0600
> Subject: [PATCH] DSPBRIDGE: Remove SEEK_* redefinitions
>
> This patch removes the SEEK_* redefinitions in host_os.h
>
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/include/dspbridge/host_os.h |=C2=A0=C2=A0=C2=
=A0 6 ------
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
> -/*=C2=A0 ----------------------------------- Macros */
> -
> -#define SEEK_SET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Seek from beginning of file.=
=C2=A0 */
> -#define SEEK_CUR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Seek from current position.=C2=
=A0 */
> -#define SEEK_END=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Seek from end of file.=C2=A0=
 */
> -
> =C2=A0/* TODO -- Remove, once BP defines them */
> =C2=A0#define INT_MAIL_MPU_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 26
> =C2=A0#define INT_DSP_MMU_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 28
> --
> 1.5.6.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

What encoding are you using for composing this patch?
There seems to be some strange characters in the patch.
I can see them when I select show original message from gmail.

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
