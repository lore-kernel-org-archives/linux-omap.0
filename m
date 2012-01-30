From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 4/5] staging: tidspbridge: silence the compiler
Date: Mon, 30 Jan 2012 11:28:37 -0600
Message-ID: <CAB-zwWijsdydtK09h41ogkp+vgsbqL5eyneVQcNT1ehupGFS9A@mail.gmail.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
	<1ceb6f764f01fce26243d899d899f84ad26e4bd4.1327348286.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ceb6f764f01fce26243d899d899f84ad26e4bd4.1327348286.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?V=EDctor_Manuel_J=E1quez_Leal?= <vjaquez@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

2012/1/23 V=EDctor Manuel J=E1quez Leal <vjaquez@igalia.com>:
> Silence the warning when compiling drv_interface.c
>
> Signed-off-by: V=EDctor Manuel J=E1quez Leal <vjaquez@igalia.com>
> ---
> =A0drivers/staging/tidspbridge/rmgr/drv_interface.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drive=
rs/staging/tidspbridge/rmgr/drv_interface.c
> index c7015f5..3bbe443 100644
> --- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
> +++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
> @@ -273,8 +273,9 @@ static int bridge_mmap(struct file *filp, struct =
vm_area_struct *vma)
> =A0 =A0 =A0 =A0vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_pr=
ot);
>
> =A0 =A0 =A0 =A0dev_dbg(bridge, "%s: vm filp %p offset %x start %lx en=
d %lx page_prot "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%lx flags %lx\n", __func__, filp, offs=
et,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_start, vma->vm_end, vma->vm_pag=
e_prot, vma->vm_flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%ulx flags %lx\n", __func__, filp, off=
set,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_start, vma->vm_end, vma->vm_pag=
e_prot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_flags);
>
> =A0 =A0 =A0 =A0status =3D remap_pfn_range(vma, vma->vm_start, vma->vm=
_pgoff,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vma->=
vm_end - vma->vm_start,
> --
> 1.7.8.3
>

Looks good.

Regards,

Omar
