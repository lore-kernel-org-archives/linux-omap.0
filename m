From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v5] OMAP2+: PM: omap device: API's for handling mstandby mode
Date: Wed, 1 Dec 2010 14:22:46 +0530
Message-ID: <AANLkTikvNNhNLYz9r5J5viajcRWW1zDrsfpTOK038k+C@mail.gmail.com>
References: <1290596051-12989-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56779 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754715Ab0LAIwr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 03:52:47 -0500
Received: by qwg5 with SMTP id 5so5437573qwg.34
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 00:52:46 -0800 (PST)
In-Reply-To: <1290596051-12989-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Wed, Nov 24, 2010 at 4:24 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
>
> Since current implementation of PM run time framework does not suppor=
t
> changing sysconfig settings during middle of the on going operation,
> these API's will support the same. One API will force the device's
> sysconfig mstandby mode settings to "no standby" and other API will
> release "no standby" mode and sets it to "smart standby" or "no
> standby=CB=9D depending on HWMOD_SWSUP_MSTANDBY value.
>
> These API's should be used by device drivers only incase of
> erratum applicable to their modules if there is no other methods
> to resolve.
>
> These API's are required for multiple DMA errata which require
> putting DMA controller in no mstandby mode before stopping dma.
>
> The applicable errata:
> 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
>
> 2. Erratum ID: i541
> sDMA FIFO draining does not finish. Applicable to all omap2+ except
> omap4.
>
> 3. Erratum ID:i88
> The sDMA to be put in no mstandby mode before disabling the channel
> after completing the data transfer operation.
> Applicable only for OMAP3430 ES1.0
>
> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> omap_hwmod.h
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> Change summary:
> v3: Review comments incorporated for:
> https://patchwork.kernel.org/patch/282212/
> v4: added mutex changes
> v5: typo fixes for errata and erratum
>
> =C2=A0arch/arm/mach-omap2/omap_hwmod.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 43 ++++++++++++++++-
> =C2=A0arch/arm/plat-omap/include/plat/omap_device.h | =C2=A0 =C2=A02 =
+
> =C2=A0arch/arm/plat-omap/include/plat/omap_hwmod.h =C2=A0| =C2=A0 =C2=
=A04 +-
> =C2=A0arch/arm/plat-omap/omap_device.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 64 +++++++++++++++++++++++++
> =C2=A04 files changed, 111 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 5a30658..de78441 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1427,6 +1427,48 @@ int omap_hwmod_set_slave_idlemode(struct omap_=
hwmod *oh, u8 idlemode)
> =C2=A0}
>
> =C2=A0/**
> + * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby =
mode
> + * @oh: struct omap_hwmod *
> + * @midlemode: flag to set mstandby to either "no standby" or "smart=
 standby"
> + *
> + * Sets the IP block's OCP mstandby mode in hardware, and updates ou=
r
> + * local copy. =C2=A0Intended to be used by drivers that have some e=
rratum
> + * that requires direct manipulation of the MIDLEMODE bits. =C2=A0Re=
turns
> + * -EINVAL if @oh is null, or passes along the return value from
> + * _set_master_standbymode().
> + *
> + * Any users of this function should be scrutinized carefully.
> + */
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idle=
mode)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 v;
> + =C2=A0 =C2=A0 =C2=A0 u8 sf;
> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!oh)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!oh->class->sysc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 v =3D oh->_sysc_cache;
> + =C2=A0 =C2=A0 =C2=A0 sf =3D oh->class->sysc->sysc_flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sf & SYSC_HAS_MIDLEMODE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (idlemode)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 idlemode =3D HWMOD_IDLEMODE_NO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 idlemode =3D (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_=
SMART;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 retval =3D _set_master_standbymode(oh, idlemod=
e, &v);
> + =C2=A0 =C2=A0 =C2=A0 if (!retval)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _write_sysconfig(v=
, oh);
> +
> + =C2=A0 =C2=A0 =C2=A0 return retval;
> +}
> +
> +/**
> =C2=A0* omap_hwmod_register - register a struct omap_hwmod
> =C2=A0* @oh: struct omap_hwmod *
> =C2=A0*
> @@ -2116,4 +2158,3 @@ int omap_hwmod_for_each_by_class(const char *cl=
assname,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> -
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm=
/plat-omap/include/plat/omap_device.h
> index 28e2d1a..4fbf7c1 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device =
*od);
> =C2=A0int omap_device_disable_clocks(struct omap_device *od);
> =C2=A0int omap_device_enable_clocks(struct omap_device *od);
>
> +int omap_device_require_no_mstandby(struct platform_device *pdev);
> +int omap_device_release_no_mstandby(struct platform_device *pdev);
>
> =C2=A0/*
> =C2=A0* Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index 7eaa8ed..c7ff65a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -354,7 +354,7 @@ struct omap_hwmod_omap4_prcm {
> =C2=A0*
> =C2=A0* HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring modu=
le in and out
> =C2=A0* =C2=A0 =C2=A0 of idle, rather than relying on module smart-id=
le
> - * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module =
in and out
> + * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring modul=
e in and out
> =C2=A0* =C2=A0 =C2=A0 of standby, rather than relying on module smart=
-standby
> =C2=A0* HWMOD_INIT_NO_RESET: don't reset this module at boot - import=
ant for
> =C2=A0* =C2=A0 =C2=A0 SDRAM controller, etc.
> @@ -526,6 +526,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *=
oh);
>
> =C2=A0int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idl=
emode);
>
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idle=
mode);
> +
> =C2=A0int omap_hwmod_reset(struct omap_hwmod *oh);
> =C2=A0void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index abe933c..fa99551 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -584,6 +584,70 @@ int omap_device_idle(struct platform_device *pde=
v)
> =C2=A0}
>
> =C2=A0/**
> + * omap_device_require_no_mstandby - set no mstandby mode of an omap=
_device
> + * @od: struct omap_device * to idle
> + *
> + * Sets the IP block's OCP master standby to no mstandby mode in har=
dware.
> + *
> + * Intended to be used by drivers that have some erratum that requir=
es direct
> + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> + * omap_device is not currently enabled or passes along the return v=
alue
> + * of omap_hwmod_set_master_standbymode().
> + */
> +int omap_device_require_no_mstandby(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =C2=A0=3D 0, i;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_device *od;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod *oh;
> +
> + =C2=A0 =C2=A0 =C2=A0 od =3D _find_by_pdev(pdev);
> + =C2=A0 =C2=A0 =C2=A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(1, "omap_devi=
ce: %s.%d: %s() called from invalid state %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
od->pdev.name, od->pdev.id, __func__, od->_state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 oh =3D *od->hwmods;

     I Guess you are missing oh++ in the following loop.
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < od->hwmods_cnt; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D omap_hwmod=
_set_master_standbymode(oh, true);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> + * omap_device_release_no_mstandby - releases no mstandby mode of an=
 omap_device
> + * @od: struct omap_device * to idle
> + *
> + * Release no mstandby mode and sets the master standby to either no=
 standby or
> + * smart standby in IP block's OCP in hardware depending on status o=
f the flag
> + * HWMOD_SWSUP_MSTANDBY.
> + *
> + * Intended to be used by drivers that have some erratum that requir=
es direct
> + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> + * omap_device is not currently enabled or passes along the return v=
alue
> + * of omap_hwmod_set_master_standbymode().
> + */
> +int omap_device_release_no_mstandby(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =C2=A0=3D 0, i;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_device *od;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod *oh;
> +
> + =C2=A0 =C2=A0 =C2=A0 od =3D _find_by_pdev(pdev);
> + =C2=A0 =C2=A0 =C2=A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(1, "omap_devi=
ce: %s.%d: %s() called from invalid state %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
od->pdev.name, od->pdev.id, __func__, od->_state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 oh =3D *od->hwmods;

     Same comment here.
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < od->hwmods_cnt; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D omap_hwmod=
_set_master_standbymode(oh, false);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> =C2=A0* omap_device_shutdown - shut down an omap_device
> =C2=A0* @od: struct omap_device * to shut down
> =C2=A0*
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
