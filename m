From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/7] DSPBRIDGE: do not call follow_page
Date: Mon, 20 Dec 2010 16:10:41 +0200
Message-ID: <AANLkTinPpiOjbRjcqqyYxkqbMABd_+4iadd+Vodm+4pH@mail.gmail.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
	<1274976134-22769-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:53220 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab0LTOKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 09:10:44 -0500
Received: by bwz16 with SMTP id 16so3311907bwz.4
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 06:10:42 -0800 (PST)
In-Reply-To: <1274976134-22769-4-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Thu, May 27, 2010 at 7:02 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Eliminate the call to follow_page. Instead, use the page
> information that was kept during the proc_map call.
> This also has the advantage that users can now only
> specify memory areas that were previously mapped.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

I found another issue with this patch:

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
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("%s: In=
Valid address parameters %p %x\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0__func__, pmpu_addr, ul_size);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, pmpu_addr, ul_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D -EF=
AULT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

find_containing_mapping() is taking the lock for dmm_map_list,
however, nothing prevents the map_obj to be destroyed after that,
specially if kcalloc sleeps, and then an unmap happens. While doing
some stress testing I found there's a race condition that makes
exactly that happen.

I'm sending some patches to fix that.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
