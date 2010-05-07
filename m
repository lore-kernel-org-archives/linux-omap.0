From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/5] omap iommu: Fix superpage unalignment at allocation
	of iovm areas
Date: Fri, 7 May 2010 10:19:33 +0300
Message-ID: <n2u94a0d4531005070019o7c40e334rde44fcc636bf2a2b@mail.gmail.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1273215364-15098-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54642 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0EGHTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 03:19:35 -0400
Received: by bwz19 with SMTP id 19so400075bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 07 May 2010 00:19:33 -0700 (PDT)
In-Reply-To: <1273215364-15098-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com

On Fri, May 7, 2010 at 9:56 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Superpage addresses should be aligned on mapping size of 4KB, 64KB,
> 1MB and 16MB respectively both for physical and device virtual
> addresses.
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0122 ++++++++++++++++++++++++=
+------------------
> =C2=A01 files changed, 71 insertions(+), 51 deletions(-)

> @@ -127,13 +100,8 @@ static struct sg_table *sgtable_alloc(const size=
_t bytes, u32 flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ALIGNED(bytes, PAGE_SIZE))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(-EINVAL);
>
> - =C2=A0 =C2=A0 =C2=A0 /* FIXME: IOVMF_DA_FIXED should support 'super=
pages' */
> - =C2=A0 =C2=A0 =C2=A0 if ((flags & IOVMF_LINEAR) && (flags & IOVMF_D=
A_ANON)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_entries =3D sgt=
able_nents(bytes);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nr_entries)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ERR_PTR(-EINVAL);
> - =C2=A0 =C2=A0 =C2=A0 } else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_entries =3D =C2=
=A0bytes / PAGE_SIZE;
> + =C2=A0 =C2=A0 =C2=A0 /* FIXME: Maximam number of entries are always=
 prepared. */

Typo: maximum.

> +static void alloc_area_by_size(u32 start, u32 end, u32 unit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist **_sg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 addr;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (unit =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (start =3D=3D end)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 addr =3D ALIGN(start, unit);
> + =C2=A0 =C2=A0 =C2=A0 if (addr > end) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* retry with smal=
ler granularity */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alloc_area_by_size=
(start, end, iopgsz_max(unit - 1), _sg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* lower chuck with smaller granularity */

Typo: chunk (I guess).

> + =C2=A0 =C2=A0 =C2=A0 alloc_area_by_size(start, addr, iopgsz_max(uni=
t - 1), _sg);
> +
> + =C2=A0 =C2=A0 =C2=A0 addr =3D __alloc_area_by_size(addr, end, unit,=
 _sg);
> + =C2=A0 =C2=A0 =C2=A0 if (addr < end)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* higher chuck wi=
th smaller granularity */

Another typo?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
