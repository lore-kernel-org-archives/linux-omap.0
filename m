From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP2/3 V4L2: Add support for OMAP2/3 V4L2 driver
 on 	top of DSS2
Date: Wed, 7 Apr 2010 15:30:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DF7F9CC@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1270115880-21404-2-git-send-email-hvaibhav@ti.com>
 <z2j55a3e0ce1004021303rdf3092f7r87b119cd97687f9b@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E7394044DF7F789@dbde02.ent.ti.com>
 <A69FA2915331DC488A831521EAE36FE4016A92D8CF@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab0DGKBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 06:01:12 -0400
In-Reply-To: <A69FA2915331DC488A831521EAE36FE4016A92D8CF@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Muralidharan Karicheri <mkaricheri@gmail.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "mchehab@redhat.com" <mchehab@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Karicheri, Muralidharan
> Sent: Tuesday, April 06, 2010 11:56 PM
> To: Hiremath, Vaibhav; Muralidharan Karicheri
> Cc: linux-media@vger.kernel.org; mchehab@redhat.com; linux-
> omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH 1/2] OMAP2/3 V4L2: Add support for OMAP2/3 V4L2 d=
river
> on top of DSS2
>=20
>=20
> Vaibhav,
>=20
> >>
> >[Hiremath, Vaibhav] Thanks Murali, I really appreciate your comments=
 here.
> >Please find response below -
>=20
> You had responded only to some comments. Can I assume that you are ta=
king
> care of the other comments as well?=20
[Hiremath, Vaibhav] Yesterday I was replying from home so replied on on=
ly important comments. Today I went through all of the comments, most o=
f them are valid comments and I accept most of them except 2 -

> +static u32 omap_vout_uservirt_to_phys(u32 virtp)
> +{
> + =A0 =A0 =A0 unsigned long physp =3D 0;
> + =A0 =A0 =A0 struct vm_area_struct *vma;
> + =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> +
> + =A0 =A0 =A0 vma =3D find_vma(mm, virtp);
> + =A0 =A0 =A0 /* For kernel direct-mapped memory, take the easy way *=
/
> + =A0 =A0 =A0 if (virtp >=3D PAGE_OFFSET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D virt_to_phys((void *) virtp);
> + =A0 =A0 =A0 } else if (vma && (vma->vm_flags & VM_IO)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && vma->vm_pgoff) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will catch, kernel-allocated,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmaped-to-usermode addresses */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D (vma->vm_pgoff << PAGE_SHIFT)=
 + (virtp - vma->vm_start);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* otherwise, use get_user_pages() for =
general userland pages */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int res, nr_pages =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct page *pages;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D get_user_pages(current, current=
->mm, virtp, nr_pages,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, 0, &=
pages, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D nr_pages) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D =A0__pa(page_=
address(&pages[0]) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (virtp & ~PAGE_MASK));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING VOU=
T_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "get_user_pages failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return physp;
> +}

[Murali] Shouldn't we remove omap_vout_uservirt_to_phys() and use video=
buf_iolock() instead as we have done in vpfe_capture.c?

As mentioned before, in my opinion we can address this in sub-sequent p=
atch series, and should not block this patch in getting to main-line.

> +/*
> + * Convert V4L2 pixel format to DSS pixel format
> + */
> +static enum omap_color_mode video_mode_to_dss_mode(struct omap_vout_=
device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *vout)
> +{
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &vout->pix;
> +
> + =A0 =A0 =A0 ovid =3D &vout->vid_info;
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 switch (pix->pixelformat) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_YUYV:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_YUV2;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_UYVY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_UYVY;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB565:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB16;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB24P;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (ovl->id =3D=3D OMAP_DSS_VIDEO1)=
 ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_COLOR_RGB24U :=
 OMAP_DSS_COLOR_ARGB32;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_BGR32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGBX32;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;

[Murali] Also return type is enum and you are returning a negative numb=
er here ???

I think yes it is acceptable, since ultimately enum is of type integer =
constant. You can return the value which fits into this size.


> I have also asked Hans to provide
> his comments since this is a new driver that he might have to approve=
=2E Did
> he review the code in the past?
>=20
[Hiremath, Vaibhav] Yes he reviewed it some time back; anyway he has al=
ready provided few more comments now which I have already fixed. The pa=
tch is following this reply.

Thanks,
Vaibhav

> -Murali
> >
<snip>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
