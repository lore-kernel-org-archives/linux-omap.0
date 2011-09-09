From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv7 3/9] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Fri, 9 Sep 2011 10:45:55 +0200
Message-ID: <CAORVsuXy4K+DTaT7eXBb6mNrCoZinckEr0K0dfG6NYMq08sb2A@mail.gmail.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
	<1315495344-23133-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62890 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab1IIIp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 04:45:56 -0400
Received: by vxi9 with SMTP id 9so916115vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 01:45:55 -0700 (PDT)
In-Reply-To: <1315495344-23133-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, govindraj.raja@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com

Hi Tero, Govindraj,

On Thu, Sep 8, 2011 at 5:22 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: R, Govindraj <govindraj.raja@ti.com>
>
> Add API to determine IO-PAD wakeup event status for a given
> hwmod dynamic_mux pad.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 30 ++++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 13 +++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 ++++++
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
> =A04 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index c7fb22a..50ee806 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -351,6 +351,36 @@ err1:
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +/**
> + * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
> + * @hmux: =A0 =A0 =A0 =A0 =A0 =A0 =A0Pads for a hwmod
> + *
> + * Gets the wakeup status of given pad from omap-hwmod.
> + * Returns true if wakeup event is set for pad else false
> + * if wakeup is not occured or pads are not avialable.
> + */
This comment is unclear wrt the code below.
IMO the code says:
Returns true if the wake-up capability is enabled and a wake-up event
occured on the pad; returns false otherwise.

> +bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux=
)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned int val;
> + =A0 =A0 =A0 u8 ret =3D false;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < hmux->nr_pads; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D &hmux->=
pads[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pad->flags & OMAP_DEVICE_PAD_WAKEUP=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(p=
ad->partition,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pad->mux->reg_offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & OMAP_WAKEUP_E=
VENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
