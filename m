From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Wed, 2 Mar 2011 10:19:58 +0530
Message-ID: <AANLkTim8tTO5wDvzXxy8G35vYMBsXP2fJu=KHDHpw7aC@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com> <1298903958-6496-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49366 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757925Ab1CBEuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 23:50:39 -0500
In-Reply-To: <1298903958-6496-3-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Govind,

Couple of minor comments.

On Mon, Feb 28, 2011 at 20:09, Govindraj.R <govindraj.raja@ti.com> wrot=
e:
> For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means th=
ey
> are wakeup capable) enable the IO-daisy wakeup capability.
> During re-muxing avoid direct write with val as this can disturb if a=
ny
> mux done at bootloader level so read the pad then write back.
>
> Also add a api to fetch the wake-up status bit is set for given omap-=
hwmod

%s/a api/an API/

> device using available mux info which is added during omap_hwmod_mux_=
init.
> Wakeup status bit is needed for uart_resume_idle call from sram_idle =
path
> based on wake-up event has occurred for given uart we can enable cloc=
ks back.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 23 +++++++++++++++++++++++
> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 13 +++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 =
+++++++++++++
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
> =A04 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 98148b6..5338b93 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -317,6 +317,24 @@ err1:
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +/* Gets the wakeup status of given pad from omap-hwmod */
> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned int val =3D -EINVAL;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < hmux->nr_pads; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D &hmux->=
pads[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(pad->partition, p=
ad->mux->reg_offset);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (val > 0 && val & OMAP_WAKEUP_EVENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 else

No need of else here.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +

- V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
