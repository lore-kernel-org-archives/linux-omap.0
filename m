From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address
	instead of user's
Date: Thu, 29 Jul 2010 23:15:08 +0300
Message-ID: <AANLkTi=VW+JY-g_mvRyo=KisccR8s+cam04b+QrUtEdN@mail.gmail.com>
References: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<AANLkTikZSAqtpTqgFWKTZjn9eLD2x9ENgNMhyjckCQuj@mail.gmail.com>
	<20100729100802.8f344f05.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab0G2UPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 16:15:10 -0400
Received: by ewy23 with SMTP id 23so429150ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Jul 2010 13:15:09 -0700 (PDT)
In-Reply-To: <20100729100802.8f344f05.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>, "x0095840@ti.com" <x0095840@ti.com>, "omar.ramirez@ti.com" <omar.ramirez@ti.com>, "nm@ti.com" <nm@ti.com>

On Thu, Jul 29, 2010 at 10:08 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> On Sun, 25 Jul 2010 22:10:32 +0200
> ext Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 3:34 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>> > @@ -690,14 +732,19 @@ static int memory_check_vma(unsigned long st=
art, u32 len)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end <=3D start)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 down_read(&current->mm->mmap_sem);
>> > -
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((vma =3D find_vma(current->mm, s=
tart)) !=3D NULL) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t size;
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vma->vm_sta=
rt > start) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D -EINVAL;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vma->vm_fla=
gs & (VM_IO | VM_PFNMAP))
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vma->vm_sta=
rt > start)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D min_t(=
ssize_t, vma->vm_end - start, len);
>>
>> This 'len' is the total length, which is not what we want; in each
>> iteration the length should be decreased so that it's always the
>> remaining length. Right?
>>
>> len -=3D size;
>
> Great finding and I'm so sorry for this bug...

All right, thanks for confirming :)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
