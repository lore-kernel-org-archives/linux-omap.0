From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Wed, 10 Jun 2009 10:25:39 +0300 (EEST)
Message-ID: <20090610.102539.48529285.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53040F6B7C82@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62723 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZFJHZw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 03:25:52 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53040F6B7C82@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: felipe.contreras@gmail.com, ameya.palande@nokia.com, nm@ti.com, bagadia@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

=46rom: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Wed, 10 Jun 2009 01:18:29 +0200

> Hi,
>=20
> [sending as plain text to l-o]
>=20
> Could you please comment on this patch.
>=20
> From: Sripal Bagadia <bagadia@ti.com>
> Date: Tue, 9 Jun 2009 16:05:09 -0500
> Subject: [PATCH] DSPBRIDGE: Video Playback Cache Optimization
>=20
> Avoid get_user_pages cache flush overheads for uncached & reserved
> buffers (e.g. display & camera buffers).

Would it be possible to tell the case/path,
where no L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERVED=
 ?

>=20
> Signed-off-by: Sripal Bagadia <bagadia@ti.com>
> ---
> =A0drivers/dsp/bridge/wmd/tiomap3430.c |=A0=A0=A0 4 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge=
/wmd/tiomap3430.c
> index 7a9603d..a2f32e8 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -1461,7 +1461,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV=
_CONTEXT *hDevContext,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto func_cont;
> =A0=A0=A0=A0=A0 }
> =A0
> -=A0=A0=A0=A0 if (vma->vm_flags & VM_IO) {
> +=A0=A0=A0=A0 if ((vma->vm_flags & VM_IO) | ((vma->vm_flags & VM_RESE=
RVED) &&=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma->v=
m_page_prot) & L_PTE_CACHEABLE) &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma->v=
m_page_prot) & L_PTE_BUFFERABLE))) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 numUsrPgs =3D=A0 ulNumBytes / PG_SI=
ZE_4K;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mpuAddr =3D ulMpuAddr;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemM=
ap:numOfActualTabEntries=3D%d,"
> --=20
> 1.6.2.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
