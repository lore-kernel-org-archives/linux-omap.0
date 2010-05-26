From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 2/7] DSPBRIDGE: maintain mapping and page info
Date: Wed, 26 May 2010 12:50:52 +0300
Message-ID: <AANLkTilsuMlbu2ekx_OaYpRTqX9srUaFdeBG_XAG45C0@mail.gmail.com>
References: <1274717118-15226-1-git-send-email-ohad@wizery.com>
	<1274717118-15226-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49325 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934024Ab0EZJvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 05:51:13 -0400
Received: by gwaa12 with SMTP id a12so643823gwa.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 02:51:12 -0700 (PDT)
In-Reply-To: <1274717118-15226-3-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 24, 2010 at 7:05 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Every time the MM application calls proc_map to map
> a memory area, remember the details of that mapping,
> together with the related page structures.
> Whenever a buffer is unmapped, clean up the mapping
> information resources.
> This information is maintained as part of the
> DMM resource tracking mechanism.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> If you want, you can also reach me at < =A0ohadb at ti dot com =A0>.
>
> =A0arch/arm/plat-omap/include/dspbridge/dspdefs.h | =A0 =A03 +-
> =A0drivers/dsp/bridge/core/io_sm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 11 ++-
> =A0drivers/dsp/bridge/core/tiomap3430.c =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
9 ++-
> =A0drivers/dsp/bridge/rmgr/proc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
125 ++++++++++++++++++------
> =A04 files changed, 113 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/ar=
m/plat-omap/include/dspbridge/dspdefs.h
> index 3dfe406..f09bdbd 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
> @@ -182,7 +182,8 @@ typedef dsp_status(*fxn_brd_memwrite) (struct bri=
dge_dev_context
> =A0typedef dsp_status(*fxn_brd_memmap) (struct bridge_dev_context
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 * hDevContext, u32 ul_mpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u32 ulVirtAddr, u32 ul_num_bytes,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0u32 ulMapAttrs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0u32 ulMapAttrs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct page **mapped_pages);
>
> =A0/*
> =A0* =A0=3D=3D=3D=3D=3D=3D=3D=3D bridge_brd_mem_un_map =3D=3D=3D=3D=3D=
=3D=3D=3D
> diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/cor=
e/io_sm.c
> index d6c1a98..7fda364 100644
> --- a/drivers/dsp/bridge/core/io_sm.c
> +++ b/drivers/dsp/bridge/core/io_sm.c
> @@ -503,7 +503,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio=
_mgr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
hio_mgr->intf_fxns->
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pfn_brd_mem_map(hio_mgr->hbridge_context,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pa_curr, va_curr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size[i], map_attrs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size[i], map_attrs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DS=
P_FAILED(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0goto func_end;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pa_cur=
r +=3D page_size[i];
> @@ -568,7 +569,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio=
_mgr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
hio_mgr->intf_fxns->
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pfn_brd_mem_map(hio_mgr->hbridge_context,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pa_curr, va_curr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size[i], map_attrs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page_size[i], map_attrs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_db=
g(bridge,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"shm MMU PTE entry PA %x"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0" VA %x DSP_VA %x Size %x\n",
> @@ -636,7 +638,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio=
_mgr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 hio_mgr->ext_proc_info.ty_tlb[i].
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ul_gpp_phys,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 hio_mgr->ext_proc_info.ty_tlb[i].
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ul_dsp_virt, 0x100000, map_attrs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ul_dsp_virt, 0x100000, map_attrs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_FAILED(status))
> @@ -655,7 +658,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio=
_mgr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D hio_mgr->intf_fxns->pfn_brd=
_mem_map
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(hio_mgr->hbridge_context, l4_=
peripheral_table[i].phys_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l4_peripheral_table[i].dsp_vi=
rt_addr, HW_PAGE_SIZE4KB,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_attrs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_attrs, NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_FAILED(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_end;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i++;
> diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridg=
e/core/tiomap3430.c
> index c7b0d83..e122f04 100644
> --- a/drivers/dsp/bridge/core/tiomap3430.c
> +++ b/drivers/dsp/bridge/core/tiomap3430.c
> @@ -101,7 +101,8 @@ static dsp_status bridge_brd_mem_write(struct bri=
dge_dev_context *dev_context,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u32 ul_num_bytes, u32 ulMemType);
> =A0static dsp_status bridge_brd_mem_map(struct bridge_dev_context *hD=
evContext,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u3=
2 ul_mpu_addr, u32 ulVirtAddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32=
 ul_num_bytes, u32 ul_map_attr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32=
 ul_num_bytes, u32 ul_map_attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct page **mapped_pages);
> =A0static dsp_status bridge_brd_mem_un_map(struct bridge_dev_context =
*hDevContext,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u32 ulVirtAddr, u32 ul_num_bytes);
> =A0static dsp_status bridge_dev_create(OUT struct bridge_dev_context
> @@ -1208,7 +1209,8 @@ static dsp_status bridge_brd_mem_write(struct b=
ridge_dev_context *hDevContext,
> =A0*/
> =A0static dsp_status bridge_brd_mem_map(struct bridge_dev_context *hD=
evContext,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u3=
2 ul_mpu_addr, u32 ulVirtAddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32=
 ul_num_bytes, u32 ul_map_attr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32=
 ul_num_bytes, u32 ul_map_attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct page **mapped_pages)
> =A0{
> =A0 =A0 =A0 =A0u32 attrs;
> =A0 =A0 =A0 =A0dsp_status status =3D DSP_SOK;
> @@ -1350,6 +1352,9 @@ static dsp_status bridge_brd_mem_map(struct bri=
dge_dev_context *hDevContext,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_FAILED(status)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mapped_pages)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapped_=
pages[pg_i] =3D mapped_page;
> +


Something went bad in the rebase of this patch, these two lines are
mislocated (they should be in the else clause below, just like in the
previous version of the patches).

I'll send a v3 with the fix.

Thanks Ivan for testing MM scenarios and reporting me about the problem=
=2E

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0va +=3D HW_PAGE_SIZE4K=
B;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpu_addr +=3D HW_PAGE_=
SIZE4KB;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pa +=3D HW_PAGE_SIZE4K=
B;
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr=
/proc.c
> index 7dc9b5c..37258c4 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -108,6 +108,87 @@ static s32 get_envp_count(char **envp);
> =A0static char **prepend_envp(char **new_envp, char **envp, s32 envp_=
elems,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 cnew_envp, ch=
ar *szVar);
>
> +/* remember mapping information */
> +static struct dmm_map_object *add_mapping_info(struct process_contex=
t *pr_ctxt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mpu=
_addr, u32 dsp_addr, u32 size)
> +{
> + =A0 =A0 =A0 struct dmm_map_object *map_obj;
> +
> + =A0 =A0 =A0 u32 num_usr_pgs =3D size / PG_SIZE4K;
> +
> + =A0 =A0 =A0 pr_debug("%s: adding map info: mpu_addr 0x%x virt 0x%x =
size 0x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mpu_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 dsp_addr, size);
> +
> + =A0 =A0 =A0 map_obj =3D kzalloc(sizeof(struct dmm_map_object), GFP_=
KERNEL);
> + =A0 =A0 =A0 if (!map_obj) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kzalloc failed\n", __func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 INIT_LIST_HEAD(&map_obj->link);
> +
> + =A0 =A0 =A0 map_obj->pages =3D kcalloc(num_usr_pgs, sizeof(struct p=
age *),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> + =A0 =A0 =A0 if (!map_obj->pages) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kzalloc failed\n", __func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(map_obj);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 map_obj->mpu_addr =3D mpu_addr;
> + =A0 =A0 =A0 map_obj->dsp_addr =3D dsp_addr;
> + =A0 =A0 =A0 map_obj->size =3D size;
> + =A0 =A0 =A0 map_obj->num_usr_pgs =3D num_usr_pgs;
> +
> + =A0 =A0 =A0 spin_lock(&pr_ctxt->dmm_map_lock);
> + =A0 =A0 =A0 list_add(&map_obj->link, &pr_ctxt->dmm_map_list);
> + =A0 =A0 =A0 spin_unlock(&pr_ctxt->dmm_map_lock);
> +
> + =A0 =A0 =A0 return map_obj;
> +}
> +
> +static int match_exact_map_obj(struct dmm_map_object *map_obj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 dsp_addr, u32 size)
> +{
> + =A0 =A0 =A0 if (map_obj->dsp_addr =3D=3D dsp_addr && map_obj->size =
!=3D size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: addr match (0x%x), size don=
't (0x%x !=3D 0x%x)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, dsp_addr, map_obj->size, size);
> +
> + =A0 =A0 =A0 return map_obj->dsp_addr =3D=3D dsp_addr &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj->size =3D=3D size;
> +}
> +
> +static void remove_mapping_information(struct process_context *pr_ct=
xt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 u32 dsp_addr, u32 size)
> +{
> + =A0 =A0 =A0 struct dmm_map_object *map_obj;
> +
> + =A0 =A0 =A0 pr_debug("%s: looking for virt 0x%x size 0x%x\n", __fun=
c__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsp_addr, size);
> +
> + =A0 =A0 =A0 spin_lock(&pr_ctxt->dmm_map_lock);
> + =A0 =A0 =A0 list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, li=
nk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: candidate: mpu_addr 0x%x =
virt 0x%x size 0x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj->mpu_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj->dsp_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj->size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (match_exact_map_obj(map_obj, dsp_ad=
dr, size)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: match, de=
leting map info\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&map_obj->link=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(map_obj->pages);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(map_obj);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: candidate didn't match\n"=
, __func__);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_err("%s: failed to find given map info\n", __func__)=
;
> +out:
> + =A0 =A0 =A0 spin_unlock(&pr_ctxt->dmm_map_lock);
> +}
> +
> =A0/*
> =A0* =A0=3D=3D=3D=3D=3D=3D=3D=3D proc_attach =3D=3D=3D=3D=3D=3D=3D=3D
> =A0* =A0Purpose:
> @@ -1074,6 +1155,7 @@ dsp_status proc_map(void *hprocessor, void *pmp=
u_addr, u32 ul_size,
> =A0 =A0 =A0 =A0dsp_status status =3D DSP_SOK;
> =A0 =A0 =A0 =A0struct proc_object *p_proc_object =3D (struct proc_obj=
ect *)hprocessor;
> =A0 =A0 =A0 =A0struct dmm_map_object *map_obj;
> + =A0 =A0 =A0 u32 tmp_addr =3D 0;
>
> =A0#ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
> =A0 =A0 =A0 =A0if ((ul_map_attr & BUFMODE_MASK) !=3D RBUF) {
> @@ -1105,15 +1187,23 @@ dsp_status proc_map(void *hprocessor, void *p=
mpu_addr, u32 ul_size,
> =A0 =A0 =A0 =A0/* Add mapping to the page tables. */
> =A0 =A0 =A0 =A0if (DSP_SUCCEEDED(status)) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D (*p_proc_object->intf_fxns->=
pfn_brd_mem_map)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (p_proc_object->hbridge_context=
, pa_align, va_align,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_align, ul_map_attr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mapped address =3D MSB of VA | LSB o=
f PA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_addr =3D (va_align | ((u32) pmpu_ad=
dr & (PG_SIZE4K - 1)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* mapped memory resource tracking */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj =3D add_mapping_info(pr_ctxt, p=
a_align, tmp_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 size_align);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!map_obj)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D (*p_proc_obj=
ect->intf_fxns->pfn_brd_mem_map)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (p_proc_object-=
>hbridge_context, pa_align, va_align,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_align, =
ul_map_attr, map_obj->pages);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (DSP_SUCCEEDED(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Mapped address =3D MSB of VA | LSB =
of PA */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pp_map_addr =3D (void *)(va_align | ((=
u32) pmpu_addr &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (PG_SIZE4K - 1)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pp_map_addr =3D (void *) tmp_addr;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_mapping_information(pr_ctxt, tmp=
_addr, size_align);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dmm_un_map_memory(dmm_mgr, va_align, &=
size_align);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&proc_lock);
> @@ -1121,19 +1211,6 @@ dsp_status proc_map(void *hprocessor, void *pm=
pu_addr, u32 ul_size,
> =A0 =A0 =A0 =A0if (DSP_FAILED(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_end;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* A successful map should be followed by insertion o=
f map_obj
> - =A0 =A0 =A0 =A0* into dmm_map_list, so that mapped memory resource =
tracking
> - =A0 =A0 =A0 =A0* remains uptodate
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 map_obj =3D kmalloc(sizeof(struct dmm_map_object), GFP_=
KERNEL);
> - =A0 =A0 =A0 if (map_obj) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_obj->dsp_addr =3D (u32) *pp_map_add=
r;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&pr_ctxt->dmm_map_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&map_obj->link, &pr_ctxt->dmm_=
map_list);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&pr_ctxt->dmm_map_lock);
> - =A0 =A0 =A0 }
> -
> =A0func_end:
> =A0 =A0 =A0 =A0dev_dbg(bridge, "%s: hprocessor %p, pmpu_addr %p, ul_s=
ize %x, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"req_addr %p, ul_map_attr %x, pp_map_a=
ddr %p, va_align %x, "
> @@ -1422,7 +1499,6 @@ dsp_status proc_un_map(void *hprocessor, void *=
map_addr,
> =A0 =A0 =A0 =A0struct dmm_object *dmm_mgr;
> =A0 =A0 =A0 =A0u32 va_align;
> =A0 =A0 =A0 =A0u32 size_align;
> - =A0 =A0 =A0 struct dmm_map_object *map_obj;
>
> =A0 =A0 =A0 =A0va_align =3D PG_ALIGN_LOW((u32) map_addr, PG_SIZE4K);
> =A0 =A0 =A0 =A0if (!p_proc_object) {
> @@ -1446,6 +1522,7 @@ dsp_status proc_un_map(void *hprocessor, void *=
map_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D (*p_proc_object->intf_fxns-=
>pfn_brd_mem_un_map)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(p_proc_object->hbridge_contex=
t, va_align, size_align);
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0mutex_unlock(&proc_lock);
> =A0 =A0 =A0 =A0if (DSP_FAILED(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_end;
> @@ -1455,15 +1532,7 @@ dsp_status proc_un_map(void *hprocessor, void =
*map_addr,
> =A0 =A0 =A0 =A0 * from dmm_map_list, so that mapped memory resource t=
racking
> =A0 =A0 =A0 =A0 * remains uptodate
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 spin_lock(&pr_ctxt->dmm_map_lock);
> - =A0 =A0 =A0 list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, li=
nk) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (map_obj->dsp_addr =3D=3D (u32) map_=
addr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&map_obj->link=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(map_obj);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 spin_unlock(&pr_ctxt->dmm_map_lock);
> + =A0 =A0 =A0 remove_mapping_information(pr_ctxt, (u32) map_addr, siz=
e_align);
>
> =A0func_end:
> =A0 =A0 =A0 =A0dev_dbg(bridge, "%s: hprocessor: 0x%p map_addr: 0x%p s=
tatus: 0x%x\n",
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
