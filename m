From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Wed, 10 Jun 2009 01:51:17 +0300
Message-ID: <94a0d4530906091551g2d689300vf966564a82e24ba2@mail.gmail.com>
References: <27F9C60D11D683428E133F85D2BB4A53040F6B7BFE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:61559 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbZFIWvR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 18:51:17 -0400
Received: by fg-out-1718.google.com with SMTP id 16so113565fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 15:51:17 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53040F6B7BFE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Doyu Hiroshi <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Bagadia, Sripal" <bagadia@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 10, 2009 at 12:39 AM, Ramirez Luna, Omar<omar.ramirez@ti.co=
m> wrote:
> Hi,
>
>
>
> Could you please comment on this patch.
>
>
>
> From: Sripal Bagadia <bagadia@ti.com>
>
> Date: Tue, 9 Jun 2009 16:05:09 -0500
>
> Subject: [PATCH] DSPBRIDGE: Video Playback Cache Optimization
>
>
>
> Avoid get_user_pages cache flush overheads for uncached & reserved
>
> buffers (e.g. display & camera buffers).
>
>
>
> Signed-off-by: Sripal Bagadia <bagadia@ti.com>
>
> ---
>
> =C2=A0drivers/dsp/bridge/wmd/tiomap3430.c |=C2=A0=C2=A0=C2=A0 4 +++-
>
> =C2=A01 files changed, 3 insertions(+), 1 deletions(-)
>
>
>
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
> b/drivers/dsp/bridge/wmd/tiomap3430.c
>
> index 7a9603d..a2f32e8 100644
>
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
>
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
>
> @@ -1461,7 +1461,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct
> WMD_DEV_CONTEXT *hDevContext,
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to func_cont;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>
>
> -=C2=A0=C2=A0=C2=A0=C2=A0 if (vma->vm_flags & VM_IO) {
>
> +=C2=A0=C2=A0=C2=A0=C2=A0 if ((vma->vm_flags & VM_IO) | ((vma->vm_fla=
gs & VM_RESERVED) &&
>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (~pgprot_val(vma->vm_page_prot) & L_PTE_CAC=
HEABLE) &&
>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (~pgprot_val(vma->vm_page_prot) & L_PTE_BUF=
=46ERABLE))) {

L_PTE_BUFFERABLE is obsolete, isn't it? L_PTE_MT_BUFFERABLE should be
used instead.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
