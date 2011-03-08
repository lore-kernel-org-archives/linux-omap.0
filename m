From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH 1/3] omap: iovmm: disallow mapping NULL address
Date: Tue, 8 Mar 2011 12:06:18 -0600
Message-ID: <AANLkTikkUYFuhH-b2vKX8jVoT18wH_+WPzGbfFNWQK6K@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-2-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:60036 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752849Ab1CHSGZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 13:06:25 -0500
In-Reply-To: <1299588365-2749-2-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, Michael Jones <michael.jones@matrix-vision.de>

On Tue, Mar 8, 2011 at 6:46 AM, David Cohen <dacohen@gmail.com> wrote:
> From: Michael Jones <michael.jones@matrix-vision.de>
>
> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
> the NULL address if da_start=3D=3D0, which would then not get unmappe=
d.
> Disallow this again. =A0And spell variable 'alignment' correctly.
>
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
> =A0arch/arm/plat-omap/iovmm.c | =A0 16 ++++++++++------
> =A01 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 6dc1296..11c9b76 100644
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D obj->da_start=
 + alignment;

else part obj->da_star is always 0, so why not?
start =3D alignment;

so, why I understand, it now it is possible mapp address 0x0 only if
IOVMF_DA_ANON is not set, right? maybe that would be mention in the
patch.

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
