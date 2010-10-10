From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv2 2/3] iovmm: add superpages support to fixed da address
Date: Sun, 10 Oct 2010 18:22:11 +0300
Message-ID: <AANLkTimF5HqA0pbp7NXOXxOcuMMJWp9yuJPsw8-iPKjh@mail.gmail.com>
References: <1286226137-1233-1-git-send-email-x0095840@ti.com>
	<1286226137-1233-2-git-send-email-x0095840@ti.com>
	<1286226137-1233-3-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286226137-1233-3-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Hiroshi.DOYU@nokia.com, david.cohen@nokia.com, felipe.contreras@nokia.com, ameya.palande@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 5, 2010 at 12:02 AM, Fernando Guzman Lugo <x0095840@ti.com>=
 wrote:
> This patch adds superpages support to fixed ad address
> inside iommu_kmap function.
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 61 ++++++++++++++++++++++++=
++-----------------
> =C2=A01 files changed, 37 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 34f0012..8006a19 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -87,27 +87,37 @@ static size_t sgtable_len(const struct sg_table *=
sgt)
> =C2=A0}
> =C2=A0#define sgtable_ok(x) =C2=A0(!!sgtable_len(x))
>
> +
> +static unsigned max_alignment(u32 addr)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> + =C2=A0 =C2=A0 =C2=A0 unsigned pagesize[] =3D { SZ_16M, SZ_1M, SZ_64=
K, SZ_4K, };
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(pagesize) && addr=
 & (pagesize[i] - 1); i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;
> + =C2=A0 =C2=A0 =C2=A0 return (i < ARRAY_SIZE(pagesize)) ? pagesize[i=
] : 0;
> +}
> +
> +

I don't think those extra spaces make sense.

> =C2=A0/*
> =C2=A0* calculate the optimal number sg elements from total bytes bas=
ed on
> =C2=A0* iommu superpages
> =C2=A0*/
> -static unsigned int sgtable_nents(size_t bytes)
> +static unsigned int sgtable_nents(size_t bytes, u32 da, u32 pa)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int i;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int nr_entries;
> - =C2=A0 =C2=A0 =C2=A0 const unsigned long pagesize[] =3D { SZ_16M, S=
Z_1M, SZ_64K, SZ_4K, };
> + =C2=A0 =C2=A0 =C2=A0 unsigned int nr_entries =3D 0, ent_sz;

How about s/unsigned int/unsigned/?

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ALIGNED(bytes, PAGE_SIZE)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("%s: wr=
ong size %08x\n", __func__, bytes);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 nr_entries =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(pagesize); i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes >=3D pag=
esize[i]) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 nr_entries +=3D (bytes / pagesize[i]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bytes %=3D pagesize[i];
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 while (bytes) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ent_sz =3D max_ali=
gnment(da | pa);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ent_sz =3D min(ent=
_sz, (unsigned)iopgsz_max(bytes));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_entries++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 da +=3D ent_sz;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pa +=3D ent_sz;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes -=3D ent_sz;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(bytes);
>
> @@ -115,7 +125,8 @@ static unsigned int sgtable_nents(size_t bytes)
> =C2=A0}
>
> =C2=A0/* allocate and initialize sg_table header(a kind of 'superbloc=
k') */
> -static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags)
> +static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 da, u32 pa)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nr_entries;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> @@ -127,9 +138,8 @@ static struct sg_table *sgtable_alloc(const size_=
t bytes, u32 flags)
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
> + =C2=A0 =C2=A0 =C2=A0 if (flags & IOVMF_LINEAR) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_entries =3D sgt=
able_nents(bytes, da, pa);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!nr_entrie=
s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ERR_PTR(-EINVAL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> @@ -409,7 +419,8 @@ static inline void sgtable_drain_vmalloc(struct s=
g_table *sgt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!sgt);
> =C2=A0}
>
> -static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, size_=
t len)
> +static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 d=
a,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 size_t len)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist *sg;
> @@ -420,7 +431,8 @@ static void sgtable_fill_kmalloc(struct sg_table =
*sgt, u32 pa, size_t len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bytes;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D iopgsz_m=
ax(len);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D max_alig=
nment(da | pa);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D min(byte=
s, (size_t)iopgsz_max(len));

Why the size_t casting?

Otherwise:
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

--=20
=46elipe Contreras
