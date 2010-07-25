From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/7] DSPBRIDGE: do not call follow_page
Date: Sun, 25 Jul 2010 23:13:49 +0300
Message-ID: <AANLkTimrW7qOKmdDtNP4GcBv34yYNwzx49wkFd94o+Rz@mail.gmail.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
	<1274976134-22769-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51986 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0GYUNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jul 2010 16:13:51 -0400
Received: by ewy23 with SMTP id 23so649073ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 25 Jul 2010 13:13:50 -0700 (PDT)
In-Reply-To: <1274976134-22769-4-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi,

Just for the record, I found a problem in this patch. The next patch
in the series overrides it, so it's not that important, unless
somebody picks only this patch.

On Thu, May 27, 2010 at 7:02 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> @@ -537,23 +606,30 @@ dsp_status proc_enum_nodes(void *hprocessor, vo=
id **node_tab,
> =C2=A0}
>
> =C2=A0/* Cache operation against kernel address instead of users */
> -static int memory_sync_page(struct vm_area_struct *vma, unsigned lon=
g start,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ssize_t len, enum dsp_flushtype ftype)
> +static int memory_sync_page(struct dmm_map_object *map_obj,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long star=
t, ssize_t len, enum dsp_flushtype ftype)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct page *page;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *kaddr;

[...]

> - =C2=A0 =C2=A0 =C2=A0 if (memory_sync_vma((u32) pmpu_addr, ul_size, =
=46lushMemType)) {
> + =C2=A0 =C2=A0 =C2=A0 /* find requested memory are in cached mapping=
 information */
> + =C2=A0 =C2=A0 =C2=A0 map_obj =3D find_containing_mapping(pr_ctxt, (=
u32) pmpu_addr, ul_size);
> + =C2=A0 =C2=A0 =C2=A0 if (!map_obj) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: find_c=
ontaining_mapping failed\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D -EFAULT=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (memory_sync_page(map_obj, (u32) pmpu_addr,=
 ul_size, ul_flags)) {

It should be FlushMemType, not ul_flags.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("%s: In=
Valid address parameters %p %x\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0__func__, pmpu_addr, ul_size);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, pmpu_addr, ul_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D -EF=
AULT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
