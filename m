From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 5/6] DSPBRIDGE: do not use low level cache
	manipulation API
Date: Sun, 2 May 2010 14:56:24 +0300
Message-ID: <j2sda15981b1005020456o689de7f2ra0ecc749281cf299@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<1272746671-13423-6-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34799 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EBL4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 07:56:46 -0400
Received: by gwj19 with SMTP id 19so755619gwj.19
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 04:56:44 -0700 (PDT)
In-Reply-To: <1272746671-13423-6-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Instead of using low level cache manipulation API,
> use the standard DMA API. =A0This changes the concept
> of the dspbridge cache API a little, hence the naming changes:
> * Flush marks the beginning of a DMA transfer from the MPU
> to the DSP.
> * Invalidate marks the beginning of a DMA transfer from the DSP
> to the MPU.
>
> Both of these actions eventually build a scatter gatter list
> using the page information that was kept during proc_map,
> and feed it to the standard dma_map_sg API.
> Note that now users cannot manipulate the cache state of any random
> address; if the buffer is not part of a previous memory mapping of th=
at
> application, the request is denied.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> If you want, you can also reach me at < =A0ohadb at ti dot com =A0>.
>
> =A0arch/arm/plat-omap/include/dspbridge/_dcd.h =A0 =A0 | =A0 =A04 +-
> =A0arch/arm/plat-omap/include/dspbridge/proc.h =A0 =A0 | =A0 =A04 +-
> =A0arch/arm/plat-omap/include/dspbridge/wcdioctl.h | =A0 =A04 +-
> =A0drivers/dsp/bridge/pmgr/wcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 12 +-
> =A0drivers/dsp/bridge/rmgr/proc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0152 ++++++++++++++++++-----
> =A05 files changed, 134 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/p=
lat-omap/include/dspbridge/_dcd.h
> index 1350feb..0af4a31 100644
> --- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
> +++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
> @@ -110,9 +110,9 @@ extern u32 procwrap_reserve_memory(union Trapped_=
Args *args, void *pr_ctxt);
> =A0extern u32 procwrap_un_reserve_memory(union Trapped_Args *args, vo=
id *pr_ctxt);
> =A0extern u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt);
> =A0extern u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt=
);
> -extern u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_=
ctxt);
> +extern u32 procwrap_begin_dma_to_dsp(union Trapped_Args *args, void =
*pr_ctxt);
> =A0extern u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt);
> -extern u32 procwrap_invalidate_memory(union Trapped_Args *args, void=
 *pr_ctxt);
> +extern u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, voi=
d *pr_ctxt);
>
> =A0/* NODE wrapper functions */
> =A0extern u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ct=
xt);
> diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/p=
lat-omap/include/dspbridge/proc.h
> index 0707739..f8450a6 100644
> --- a/arch/arm/plat-omap/include/dspbridge/proc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/proc.h
> @@ -472,7 +472,7 @@ extern dsp_status proc_stop(void *hprocessor);
> =A0* =A0Details:
> =A0* =A0 =A0 =A0All the arguments are currently ignored.
> =A0*/
> -extern dsp_status proc_flush_memory(void *hprocessor,
> +extern dsp_status proc_begin_dma_to_dsp(void *hprocessor,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
void *pmpu_addr, u32 ul_size, u32 ul_flags);
>
> =A0/*
> @@ -493,7 +493,7 @@ extern dsp_status proc_flush_memory(void *hproces=
sor,
> =A0* =A0Details:
> =A0* =A0 =A0 =A0All the arguments are currently ignored.
> =A0*/
> -extern dsp_status proc_invalidate_memory(void *hprocessor,
> +extern dsp_status proc_begin_dma_from_dsp(void *hprocessor,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *pmpu_addr, u32 ul_size);
>
> =A0/*
> diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/a=
rm/plat-omap/include/dspbridge/wcdioctl.h
> index b6a4dda..aba2078 100644
> --- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
> +++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
> @@ -452,9 +452,9 @@ union Trapped_Args {
> =A0#define PROC_UNRSVMEM =A0 =A0 =A0 =A0 =A0_IOW(DB, DB_IOC(DB_PROC, =
11), unsigned long)
> =A0#define PROC_MAPMEM =A0 =A0 =A0 =A0 =A0 =A0_IOWR(DB, DB_IOC(DB_PRO=
C, 12), unsigned long)
> =A0#define PROC_UNMAPMEM =A0 =A0 =A0 =A0 =A0_IOR(DB, DB_IOC(DB_PROC, =
13), unsigned long)
> -#define PROC_FLUSHMEMORY =A0 =A0 =A0 _IOW(DB, DB_IOC(DB_PROC, 14), u=
nsigned long)
> +#define PROC_BEGINDMATODSP =A0 =A0 _IOW(DB, DB_IOC(DB_PROC, 14), uns=
igned long)
> =A0#define PROC_STOP =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOWR(DB, DB_IOC(DB_P=
ROC, 15), unsigned long)
> -#define PROC_INVALIDATEMEMORY =A0_IOW(DB, DB_IOC(DB_PROC, 16), unsig=
ned long)
> +#define PROC_BEGINDMAFROMDSP =A0 _IOW(DB, DB_IOC(DB_PROC, 16), unsig=
ned long)
>
> =A0/* NODE Module */
> =A0#define NODE_ALLOCATE =A0 =A0 =A0 =A0 =A0_IOWR(DB, DB_IOC(DB_NODE,=
 0), unsigned long)
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/=
wcd.c
> index 15a05a6..89243f1 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -111,9 +111,9 @@ static struct wcd_cmd proc_cmd[] =3D {
> =A0 =A0 =A0 =A0{procwrap_un_reserve_memory}, =A0 /* PROC_UNRSVMEM */
> =A0 =A0 =A0 =A0{procwrap_map}, =A0 =A0 =A0 =A0 /* PROC_MAPMEM */
> =A0 =A0 =A0 =A0{procwrap_un_map}, =A0 =A0 =A0/* PROC_UNMAPMEM */
> - =A0 =A0 =A0 {procwrap_flush_memory}, =A0 =A0 =A0 =A0/* PROC_FLUSHME=
MORY */
> + =A0 =A0 =A0 {procwrap_begin_dma_to_dsp}, =A0 =A0/* PROC_BEGINDMATOD=
SP */
> =A0 =A0 =A0 =A0{procwrap_stop}, =A0 =A0 =A0 =A0/* PROC_STOP */
> - =A0 =A0 =A0 {procwrap_invalidate_memory}, =A0 /* PROC_INVALIDATEMEM=
ORY */
> + =A0 =A0 =A0 {procwrap_begin_dma_from_dsp}, =A0/* PROC_BEGINDMAFROMD=
SP */
> =A0};
>
> =A0/* NODE wrapper functions */
> @@ -680,7 +680,7 @@ u32 procwrap_enum_node_info(union Trapped_Args *a=
rgs, void *pr_ctxt)
> =A0/*
> =A0* =3D=3D=3D=3D=3D=3D=3D=3D procwrap_flush_memory =3D=3D=3D=3D=3D=3D=
=3D=3D
> =A0*/
> -u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
> +u32 procwrap_begin_dma_to_dsp(union Trapped_Args *args, void *pr_ctx=
t)
> =A0{
> =A0 =A0 =A0 =A0dsp_status status;
>
> @@ -688,7 +688,7 @@ u32 procwrap_flush_memory(union Trapped_Args *arg=
s, void *pr_ctxt)
> =A0 =A0 =A0 =A0 =A0 =A0PROC_WRITEBACK_INVALIDATE_MEM)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return DSP_EINVALIDARG;
>
> - =A0 =A0 =A0 status =3D proc_flush_memory(args->args_proc_flushmemor=
y.hprocessor,
> + =A0 =A0 =A0 status =3D proc_begin_dma_to_dsp(args->args_proc_flushm=
emory.hprocessor,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a=
rgs->args_proc_flushmemory.pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a=
rgs->args_proc_flushmemory.ul_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a=
rgs->args_proc_flushmemory.ul_flags);
> @@ -698,12 +698,12 @@ u32 procwrap_flush_memory(union Trapped_Args *a=
rgs, void *pr_ctxt)
> =A0/*
> =A0* =3D=3D=3D=3D=3D=3D=3D=3D procwrap_invalidate_memory =3D=3D=3D=3D=
=3D=3D=3D=3D
> =A0*/
> -u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ct=
xt)
> +u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, void *pr_c=
txt)
> =A0{
> =A0 =A0 =A0 =A0dsp_status status;
>
> =A0 =A0 =A0 =A0status =3D
> - =A0 =A0 =A0 =A0 =A0 proc_invalidate_memory(args->args_proc_invalida=
tememory.hprocessor,
> + =A0 =A0 =A0 =A0 =A0 proc_begin_dma_from_dsp(args->args_proc_invalid=
atememory.hprocessor,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a=
rgs->args_proc_invalidatememory.pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a=
rgs->args_proc_invalidatememory.ul_size);
> =A0 =A0 =A0 =A0return status;
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr=
/proc.c
> index bbc7e0f..8a76681 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -18,6 +18,8 @@
>
> =A0/* ------------------------------------ Host OS */
> =A0#include <linux/list.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> =A0#include <linux/spinlock.h>
> =A0#include <dspbridge/host_os.h>
>
> @@ -80,6 +82,7 @@
> =A0#define WBUF =A0 =A0 =A0 =A0 =A0 0x8000 =A0 =A0 =A0 =A0 =A0/* Outp=
ut Buffer */
>
> =A0extern char *iva_img;
> +extern struct device *bridge;
>
> =A0/* =A0----------------------------------- Globals */
>
> @@ -110,6 +113,18 @@ struct proc_object {
> =A0 =A0 =A0 =A0spinlock_t maps_lock;
> =A0};
>
> +/* used to cache dma mapping information */
> +struct bridge_dma_map_info {
> + =A0 =A0 =A0 /* direction of DMA in action, or DMA_NONE */
> + =A0 =A0 =A0 enum dma_data_direction dir;
> + =A0 =A0 =A0 /* number of elements requested by us */
> + =A0 =A0 =A0 int num_pages;
> + =A0 =A0 =A0 /* number of elements returned from dma_map_sg */
> + =A0 =A0 =A0 int sg_num;
> + =A0 =A0 =A0 /* list of buffers used in this DMA action */
> + =A0 =A0 =A0 struct scatterlist *sg;
> +};
> +
> =A0/* used to cache memory mapping information */
> =A0struct memory_map_info {
> =A0 =A0 =A0 =A0struct list_head node;
> @@ -118,6 +133,7 @@ struct memory_map_info {
> =A0 =A0 =A0 =A0u32 dsp_addr;
> =A0 =A0 =A0 =A0u32 size;
> =A0 =A0 =A0 =A0u32 num_usr_pgs;
> + =A0 =A0 =A0 struct bridge_dma_map_info dma_info;
> =A0};
>
> =A0static u32 refs;
> @@ -130,7 +146,23 @@ static s32 get_envp_count(char **envp);
> =A0static char **prepend_envp(char **new_envp, char **envp, s32 envp_=
elems,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 cnew_envp, ch=
ar *szVar);
>
> -/* remember mapping information */
> +/* Mapping and Page info caching
> + *
> + * The map_info mechanism is built to remember the (struct page *)
> + * pointers of all pages per a specific memory mapping of a specific
> + * process.
> + * Whenever a memory area is mapped, get_user_pages is used to pin t=
he
> + * relevant pages in memory. As a result of running get_user_pages,
> + * we get the pointers to the page structures, which we now keep in
> + * the memory_map_info struct.
> + * Then, any time the user (the MM application) intends to begin
> + * a DMA (Direct Memory Access) operation to/from the remote process=
or,
> + * we use this cached page information to build a scatter gatter lis=
t
> + * which is given to the standard DMA API (which takes care of low
> + * level cache manipulation).
> + * Currently a simple linked list is used to cache the memory mappin=
g
> + * info per process. This can be further optimized if needed.
> + */
> =A0static struct memory_map_info *add_mapping_info(struct proc_object=
 *pr_obj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 mp=
u_addr, u32 dsp_addr, u32 size)
> =A0{
> @@ -197,6 +229,7 @@ static void remove_mapping_information(struct pro=
c_object *pr_obj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (match_exact_map_info(map_info, dsp=
_addr, size)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: match, d=
eleting map info\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del(&map_info->no=
de);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(map_info->dma_inf=
o.sg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(map_info->pages)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(map_info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> @@ -625,50 +658,109 @@ dsp_status proc_enum_nodes(void *hprocessor, v=
oid **node_tab,
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> -/* Cache operation against kernel address instead of users */
> -static int memory_sync_page(struct memory_map_info *map_info,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start, ssize_t len, enum =
dsp_flushtype ftype)
> +static int build_dma_sg(struct memory_map_info *map_info, unsigned l=
ong start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ssize_t len, int pg_i)
> =A0{
> =A0 =A0 =A0 =A0struct page *page;
> - =A0 =A0 =A0 void *kaddr;
> =A0 =A0 =A0 =A0unsigned long offset;
> =A0 =A0 =A0 =A0ssize_t rest;
> - =A0 =A0 =A0 int pg_i;
> -
> - =A0 =A0 =A0 pg_i =3D find_first_page_in_cache(map_info, start);
> - =A0 =A0 =A0 if (pg_i < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: failed to find first page i=
n cache\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 int ret =3D 0, i =3D 0;
> + =A0 =A0 =A0 struct scatterlist *sg =3D map_info->dma_info.sg;
>
> =A0 =A0 =A0 =A0while (len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0page =3D get_mapping_page(map_info, pg=
_i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!page) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: no page fo=
r %08lx\n", __func__, start);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (IS_ERR(page)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: err page f=
or %08lx(%lu)\n", __func__, start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PTR_ERR(p=
age));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(page);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(page);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D start & ~PAGE_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kaddr =3D kmap(page) + offset;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rest =3D min_t(ssize_t, PAGE_SIZE - of=
fset, len);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_flush_cache(kaddr, rest, ftype);


as a result, we can now have this as well:


diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h
b/arch/arm/plat-omap/include/
index 087f69f..4d9b33b 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -124,21 +124,6 @@ extern void *mem_calloc(IN u32 byte_size, IN enum
mem_poolattrs
 extern void mem_exit(void);

 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D mem_flush_cache =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Performs system cache sync with discard
- *  Parameters:
- *      pMemBuf:    Pointer to memory region to be flushed.
- *      pMemBuf:    Size of the memory region to be flushed.
- *  Returns:
- *  Requires:
- *      MEM is initialized.
- *  Ensures:
- *      Cache is synchronized
- */
-extern void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushTyp=
e);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D mem_free_phys_mem =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Free the given block of physically contiguous memory.
diff --git a/drivers/dsp/bridge/services/mem.c
b/drivers/dsp/bridge/services/mem.c
index 916a49f..dfb17cf 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -212,39 +212,6 @@ void mem_exit(void)
 }

 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D mem_flush_cache =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Flush cache
- */
-void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType)
-{
-       if (!pMemBuf)
-               return;
-
-       switch (FlushType) {
-               /* invalidate only */
-       case PROC_INVALIDATE_MEM:
-               dmac_inv_range(pMemBuf, pMemBuf + byte_size);
-               outer_inv_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf=
 +
-                                                         byte_size));
-               break;
-               /* writeback only */
-       case PROC_WRITEBACK_MEM:
-               dmac_clean_range(pMemBuf, pMemBuf + byte_size);
-               outer_clean_range(__pa((u32) pMemBuf), __pa((u32) pMemB=
uf +
-                                                           byte_size))=
;
-               break;
-               /* writeback and invalidate */
-       case PROC_WRITEBACK_INVALIDATE_MEM:
-               dmac_flush_range(pMemBuf, pMemBuf + byte_size);
-               outer_flush_range(__pa((u32) pMemBuf), __pa((u32) pMemB=
uf +
-                                                           byte_size))=
;
-               break;
-       }
-
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D mem_free_phys_mem =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Free the given block of physically contiguous memory.



>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(page);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_page(&sg[i], page, rest, offset)=
;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len -=3D rest;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start +=3D rest;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pg_i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pg_i++, i++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (i !=3D map_info->dma_info.num_pages) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: bad number of sg iterations=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/* Cache operation against kernel address instead of users */
> +static int memory_release_ownership(struct memory_map_info *map_info=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start, ssize_t len, enum =
dma_data_direction dir)
> +{
> + =A0 =A0 =A0 int pg_i, ret, sg_num;
> + =A0 =A0 =A0 struct scatterlist *sg;
> + =A0 =A0 =A0 unsigned long first_data_page =3D start >> PAGE_SHIFT;
> + =A0 =A0 =A0 unsigned long last_data_page =3D ((u32)(start + len - 1=
) >> PAGE_SHIFT);
> + =A0 =A0 =A0 /* calculating the number of pages this area spans */
> + =A0 =A0 =A0 unsigned long num_pages =3D last_data_page - first_data=
_page + 1;
> +
> + =A0 =A0 =A0 pg_i =3D find_first_page_in_cache(map_info, start);
> + =A0 =A0 =A0 if (pg_i < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: failed to find first page i=
n cache\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sg =3D kcalloc(num_pages, sizeof(*sg), GFP_KERNEL);
> + =A0 =A0 =A0 if (!sg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kcalloc failed\n", __func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sg_init_table(sg, num_pages);
> +
> + =A0 =A0 =A0 /* cleanup a previous sg allocation */
> + =A0 =A0 =A0 /* this may happen if application doesn't signal for e/=
o DMA */
> + =A0 =A0 =A0 kfree(map_info->dma_info.sg);
> +
> + =A0 =A0 =A0 map_info->dma_info.sg =3D sg;
> + =A0 =A0 =A0 map_info->dma_info.dir =3D dir;
> + =A0 =A0 =A0 map_info->dma_info.num_pages =3D num_pages;
> +
> + =A0 =A0 =A0 ret =3D build_dma_sg(map_info, start, len, pg_i);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto kfree_sg;
> +
> + =A0 =A0 =A0 sg_num =3D dma_map_sg(bridge, sg, num_pages, dir);
> + =A0 =A0 =A0 if (sg_num < 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: dma_map_sg failed: %d\n", _=
_func__, sg_num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto kfree_sg;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pr_debug("%s: dma_map_sg mapped %d elements\n", __func_=
_, sg_num);
> + =A0 =A0 =A0 map_info->dma_info.sg_num =3D sg_num;
> +
> =A0 =A0 =A0 =A0return 0;
> +
> +kfree_sg:
> + =A0 =A0 =A0 kfree(sg);
> + =A0 =A0 =A0 map_info->dma_info.sg =3D NULL;
> +out:
> + =A0 =A0 =A0 return ret;
> =A0}
>
> -static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u32 ul_size, u32 ul_flags,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
enum dsp_flushtype ftype)
> +static dsp_status proc_begin_dma(void *hprocessor, void *pmpu_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 ul_size, u32 ul_flags,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enum dma_data_direction dir)
> =A0{
> =A0 =A0 =A0 =A0/* Keep STATUS here for future additions to this funct=
ion */
> =A0 =A0 =A0 =A0dsp_status status =3D DSP_SOK;
> @@ -684,7 +776,7 @@ static dsp_status proc_memory_sync(void *hprocess=
or, void *pmpu_addr,
>
> =A0 =A0 =A0 =A0pr_debug("%s: addr 0x%x, size 0x%x, type %d\n", __func=
__,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(u32)pmpu_addr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ul_size, ftype);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ul_size, dir);
>
> =A0 =A0 =A0 =A0/* find requested memory are in cached mapping informa=
tion */
> =A0 =A0 =A0 =A0map_info =3D find_containing_mapping(p_proc_object, (u=
32) pmpu_addr,
> @@ -695,7 +787,8 @@ static dsp_status proc_memory_sync(void *hprocess=
or, void *pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (memory_sync_page(map_info, (u32) pmpu_addr, ul_size=
, ftype)) {
> + =A0 =A0 =A0 if (memory_release_ownership(map_info, (u32) pmpu_addr,=
 ul_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dir)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: InValid address parameters=
 %p %x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, pmpu_addr, ul_s=
ize);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D DSP_EHANDLE;
> @@ -710,13 +803,12 @@ err_out:
> =A0* =A0Purpose:
> =A0* =A0 =A0 Flush cache
> =A0*/
> -dsp_status proc_flush_memory(void *hprocessor, void *pmpu_addr,
> +dsp_status proc_begin_dma_to_dsp(void *hprocessor, void *pmpu_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ul_size, =
u32 ul_flags)
> =A0{
> - =A0 =A0 =A0 enum dsp_flushtype mtype =3D PROC_WRITEBACK_INVALIDATE_=
MEM;
> + =A0 =A0 =A0 enum dma_data_direction dir =3D DMA_BIDIRECTIONAL;
>
> - =A0 =A0 =A0 return proc_memory_sync(hprocessor, pmpu_addr, ul_size,=
 ul_flags,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtype);
> + =A0 =A0 =A0 return proc_begin_dma(hprocessor, pmpu_addr, ul_size, u=
l_flags, dir);
> =A0}
>
> =A0/*
> @@ -724,12 +816,12 @@ dsp_status proc_flush_memory(void *hprocessor, =
void *pmpu_addr,
> =A0* =A0Purpose:
> =A0* =A0 =A0 Invalidates the memory specified
> =A0*/
> -dsp_status proc_invalidate_memory(void *hprocessor, void *pmpu_addr,
> +dsp_status proc_begin_dma_from_dsp(void *hprocessor, void *pmpu_addr=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u3=
2 ul_size)
> =A0{
> - =A0 =A0 =A0 enum dsp_flushtype mtype =3D PROC_INVALIDATE_MEM;
> + =A0 =A0 =A0 enum dma_data_direction dir =3D DMA_FROM_DEVICE;
>
> - =A0 =A0 =A0 return proc_memory_sync(hprocessor, pmpu_addr, ul_size,=
 0, mtype);
> + =A0 =A0 =A0 return proc_begin_dma(hprocessor, pmpu_addr, ul_size, 0=
, dir);
> =A0}
>
> =A0/*
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
