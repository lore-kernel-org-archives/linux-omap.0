From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: protect dmm_map properly
Date: Mon, 20 Dec 2010 12:30:27 -0600
Message-ID: <AANLkTi=C4hvf9t9j51TE3JNdygHbjf-vAQBvdf+Oimfh@mail.gmail.com>
References: <1292865120-24020-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292865120-24020-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org

=46elipe,

On Mon, Dec 20, 2010 at 11:12 AM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> We need to protect not only the dmm_map list, but the individual
> map_obj's, otherwise, we might be building the scatter-gather list wi=
th
> garbage. So, use the existing proc_lock for that.
>
> I observed race conditions which caused kernel panics while running
> stress tests. This patch fixes those.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---
> =A0drivers/staging/tidspbridge/rmgr/proc.c | =A0 18 ++++++++++++++---=
-
> =A01 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/stagin=
g/tidspbridge/rmgr/proc.c
> index b47d7aa..21052e3 100644
> --- a/drivers/staging/tidspbridge/rmgr/proc.c
> +++ b/drivers/staging/tidspbridge/rmgr/proc.c
> @@ -781,12 +781,14 @@ int proc_begin_dma(void *hprocessor, void *pmpu=
_addr, u32 ul_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(u32)pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ul_size, dir);
>
> + =A0 =A0 =A0 mutex_lock(&proc_lock);

May be you should use mutex_lock_interruptable instead of  mutex_lock.

> +
> =A0 =A0 =A0 =A0/* find requested memory are in cached mapping informa=
tion */
> =A0 =A0 =A0 =A0map_obj =3D find_containing_mapping(pr_ctxt, (u32) pmp=
u_addr, ul_size);
> =A0 =A0 =A0 =A0if (!map_obj) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: find_containing_mapping fa=
iled\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EFAULT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_map;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (memory_give_ownership(map_obj, (u32) pmpu_addr, ul=
_size, dir)) {
> @@ -795,6 +797,8 @@ int proc_begin_dma(void *hprocessor, void *pmpu_a=
ddr, u32 ul_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EFAULT;
> =A0 =A0 =A0 =A0}
>
> +no_map:
> + =A0 =A0 =A0 mutex_unlock(&proc_lock);
> =A0err_out:
>
> =A0 =A0 =A0 =A0return status;
> @@ -819,12 +823,14 @@ int proc_end_dma(void *hprocessor, void *pmpu_a=
ddr, u32 ul_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(u32)pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ul_size, dir);
>
> + =A0 =A0 =A0 mutex_lock(&proc_lock);
> +
> =A0 =A0 =A0 =A0/* find requested memory are in cached mapping informa=
tion */
> =A0 =A0 =A0 =A0map_obj =3D find_containing_mapping(pr_ctxt, (u32) pmp=
u_addr, ul_size);
> =A0 =A0 =A0 =A0if (!map_obj) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: find_containing_mapping fa=
iled\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EFAULT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_map;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (memory_regain_ownership(map_obj, (u32) pmpu_addr, =
ul_size, dir)) {
> @@ -834,6 +840,8 @@ int proc_end_dma(void *hprocessor, void *pmpu_add=
r, u32 ul_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;

Mutex is not released in this case as it is released only at no_map.


> =A0 =A0 =A0 =A0}
>
> +no_map:
> + =A0 =A0 =A0 mutex_unlock(&proc_lock);
> =A0err_out:
> =A0 =A0 =A0 =A0return status;
> =A0}
> @@ -1726,9 +1734,8 @@ int proc_un_map(void *hprocessor, void *map_add=
r,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(p_proc_object->hbridge_contex=
t, va_align, size_align);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_unlock(&proc_lock);
> =A0 =A0 =A0 =A0if (status)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap_failed;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * A successful unmap should be followed by removal of=
 map_obj
> @@ -1737,6 +1744,9 @@ int proc_un_map(void *hprocessor, void *map_add=
r,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0remove_mapping_information(pr_ctxt, (u32) map_addr, si=
ze_align);
>
> +unmap_failed:
> + =A0 =A0 =A0 mutex_unlock(&proc_lock);
> +
> =A0func_end:
> =A0 =A0 =A0 =A0dev_dbg(bridge, "%s: hprocessor: 0x%p map_addr: 0x%p s=
tatus: 0x%x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, hprocessor, map_addr, status=
);
> --
> 1.7.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thank you,
Best regards,
Hari Kanigeri
