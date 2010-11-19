From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v3] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Fri, 19 Nov 2010 11:31:06 +0530
Message-ID: <20101119060106.GD25411@GLPP-machine>
References: <1290077508-6657-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56557 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab0KSGAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 01:00:42 -0500
Received: by yxm34 with SMTP id 34so2518127yxm.16
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 22:00:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290077508-6657-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Thu, Nov 18, 2010 at 04:21:48PM +0530, G, Manjunath Kondaiah wrote:
> Certain errata's in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
>=20
> Since current implementation of PM run time framework does not suppor=
t
> changing sysconfig settings during middle of the on going operation,
> these API's will support the same. One API will force the device's
> sysconfig mstandby mode settings to "no standby" and other API will
> releases "no standby" mode and sets it to "smart standby" or "no
> standby=CB=9D depending on HWMOD_SWSUP_MSTANDBY value.
>=20
> These API's should be used by device drivers only incase of
> erratum applicable to their modules if there is no other methods
> to resolve.
>=20
> These API's are required for multiple DMA errata's which require
> putting DMA controller in no mstandby mode before stopping dma.
>=20
> The applicable errata's:
> 1. Errata ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
>=20
> 2. Errata ID: i541(all omap2plus except omap4)
> sDMA FIFO draining does not finish
>=20
> 3. OMAP3430 ES1.0(Errata ID:i88) will require DMA to be put in
> no mstandby mode before disabling the channel after completing
> the data transfer operation.
>=20
> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> omap_hwmod.h
>=20
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> Change summary:
> v2: Review comments incorporated for:
> https://patchwork.kernel.org/patch/282212/
>=20
>  arch/arm/mach-omap2/omap_hwmod.c              |   45 +++++++++++++++=
-
>  arch/arm/plat-omap/include/plat/omap_device.h |    3 +-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   73 +++++++++++++++=
++++++++++
>  4 files changed, 122 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 5a30658..9c1c2fc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1427,6 +1427,50 @@ int omap_hwmod_set_slave_idlemode(struct omap_=
hwmod *oh, u8 idlemode)
>  }
> =20
>  /**
> + * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby =
mode
> + * @oh: struct omap_hwmod *
> + * @midlemode: flag to set mstandby to either "no standby" or "smart=
 standby"
> + *
> + * Sets the IP block's OCP mstandby mode in hardware, and updates ou=
r
> + * local copy.  Intended to be used by drivers that have some erratu=
m
> + * that requires direct manipulation of the MIDLEMODE bits.  Returns
> + * -EINVAL if @oh is null, or passes along the return value from
> + * _set_master_standbymode().
> + *
> + * Any users of this function should be scrutinized carefully.
> + */
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idle=
mode)
> +{
> +	u32 v;
> +	u8 sf;
> +	int retval =3D 0;
> +
> +	if (!oh)
> +		return -EINVAL;
> +
> +	v =3D oh->_sysc_cache;
> +
> +	if (!oh->class->sysc)
> +		return -EINVAL;
> +

Sorry. I forgot to take mutex here. I will add this change and repost
this patch.

-Manjunath

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
