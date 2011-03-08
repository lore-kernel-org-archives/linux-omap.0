From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v2 1/3] omap: iovmm: disallow mapping NULL address when
 IOVMF_DA_ANON is set
Date: Tue, 8 Mar 2011 14:31:58 -0600
Message-ID: <AANLkTintZ6vphJqM54SxFeKtk=6CuDQJTUpk-7jFRDeA@mail.gmail.com>
References: <1299615316-17512-1-git-send-email-dacohen@gmail.com>
	<1299615316-17512-2-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1299615316-17512-2-git-send-email-dacohen@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, Michael Jones <michael.jones@matrix-vision.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 8, 2011 at 2:15 PM, David Cohen <dacohen@gmail.com> wrote:
> From: Michael Jones <michael.jones@matrix-vision.de>
>
> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping the N=
ULL
> address if da_start=3D=3D0, which would then not get unmapped. Disall=
ow
> this again if IOVMF_DA_ANON is set. And spell variable 'alignment'
> correctly.
>
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
> =A0arch/arm/plat-omap/iovmm.c | =A0 16 ++++++++++------
> =A01 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 6dc1296..e5f8341 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -271,20 +271,24 @@ static struct iovm_struct *alloc_iovm_area(stru=
ct iommu *obj, u32 da,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 size_t bytes, u32 flags)
> =A0{
> =A0 =A0 =A0 =A0struct iovm_struct *new, *tmp;
> - =A0 =A0 =A0 u32 start, prev_end, alignement;
> + =A0 =A0 =A0 u32 start, prev_end, alignment;
>
> =A0 =A0 =A0 =A0if (!obj || !bytes)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
>
> =A0 =A0 =A0 =A0start =3D da;
> - =A0 =A0 =A0 alignement =3D PAGE_SIZE;
> + =A0 =A0 =A0 alignment =3D PAGE_SIZE;
>
> =A0 =A0 =A0 =A0if (flags & IOVMF_DA_ANON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D obj->da_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Don't map address 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (obj->da_start)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D obj->da_start=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D alignment;

looks good to me, just a nitpick comment, that would look better

                  start =3D (obj->da_start) ? obj->da_start : alignment=
;

Regards,
=46ernando.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (flags & IOVMF_LINEAR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alignement =3D iopgsz_m=
ax(bytes);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D roundup(start, alignement);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alignment =3D iopgsz_ma=
x(bytes);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D roundup(start, alignment);
> =A0 =A0 =A0 =A0} else if (start < obj->da_start || start > obj->da_en=
d ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0obj->da_end - start < bytes) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
> @@ -304,7 +308,7 @@ static struct iovm_struct *alloc_iovm_area(struct=
 iommu *obj, u32 da,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto found;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp->da_end >=3D start && flags & =
IOVMF_DA_ANON)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D roundup(tmp->=
da_end + 1, alignement);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D roundup(tmp->=
da_end + 1, alignment);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev_end =3D tmp->da_end;
> =A0 =A0 =A0 =A0}
> --
> 1.7.0.4
>
>
