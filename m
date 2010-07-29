From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address
 instead of user's
Date: Thu, 29 Jul 2010 10:08:02 +0300
Message-ID: <20100729100802.8f344f05.Hiroshi.DOYU@nokia.com>
References: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<AANLkTikZSAqtpTqgFWKTZjn9eLD2x9ENgNMhyjckCQuj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24305 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab0G2HIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 03:08:25 -0400
In-Reply-To: <AANLkTikZSAqtpTqgFWKTZjn9eLD2x9ENgNMhyjckCQuj@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>, "x0095840@ti.com" <x0095840@ti.com>, "omar.ramirez@ti.com" <omar.ramirez@ti.com>, "nm@ti.com" <nm@ti.com>

Hi Felipe,

On Sun, 25 Jul 2010 22:10:32 +0200
ext Felipe Contreras <felipe.contreras@gmail.com> wrote:

> Hi,
>=20
> While investigating a bug in maemo[1] I found that this patch trigger=
s
> it, I think I found the reason.
>=20
> It probably doesn't matter for upstream anymore.
>=20
> On Fri, Nov 6, 2009 at 3:34 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> > @@ -690,14 +732,19 @@ static int memory_check_vma(unsigned long sta=
rt, u32 len)
> > =A0 =A0 =A0 =A0if (end <=3D start)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> >
> > - =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> > -
> > =A0 =A0 =A0 =A0while ((vma =3D find_vma(current->mm, start)) !=3D N=
ULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssize_t size;
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vma->vm_start > start) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vma->vm_flags & (VM_IO | VM_PFNMA=
P))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vma->vm_start > start)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D min_t(ssize_t, vma->vm_end -=
 start, len);
>=20
> This 'len' is the total length, which is not what we want; in each
> iteration the length should be decreased so that it's always the
> remaining length. Right?
>=20
> len -=3D size;

Great finding and I'm so sorry for this bug...

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D memory_sync_page(vma, start, =
size, ftype);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (end <=3D vma->vm_end)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>=20
> [1] https://bugs.maemo.org/show_bug.cgi?id=3D10813
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
