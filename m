From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH B 1/3] tidspbridge: don't flood the mailbox on MemUnMap
Date: Wed, 18 Mar 2009 08:49:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23320B98@dlee03.ent.ti.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23320B48@dlee03.ent.ti.com>
 <94a0d4530903180629q5e410a4agebbf07266c5814dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbZCRNuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 09:50:09 -0400
In-Reply-To: <94a0d4530903180629q5e410a4agebbf07266c5814dd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

> You tell me :)
>=20
> I just moved code around. I don't truly understand what it's doing.
> Maybe the read is needed for some kind of sync?
>=20
> I've removed the tlb flush all completely and I didn't notice any
> problems, is it really needed?
>

-- Ignore my previous comment. I think temp is used for other purpose i=
n the same function. I thought temp was used by only the part of the co=
de section that you stripped out.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, March 18, 2009 8:30 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya Palande; Guzman L=
ugo,
> Fernando; Felipe Contreras
> Subject: Re: [PATCH B 1/3] tidspbridge: don't flood the mailbox on
> MemUnMap
>=20
> On Wed, Mar 18, 2009 at 3:06 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Felipe,
> >
> >> Check the hardware state of the DSP before sending the command to =
wake
> >> it up thus avoiding to flood the mailbox unnecessarily.
> >>
> > -- So this check was missing in Unmap part. Good catch.
> >
> >
> >> - =A0 =A0 u32 temp =3D 0;
> >> - =A0 =A0 struct CFG_HOSTRES resources;
> >> =A0 =A0 =A0 u32 *pPhysAddrPageTbl =3D NULL;
> >> =A0 =A0 =A0 struct vm_area_struct *vma;
> >> =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> >> + =A0 =A0 u32 temp =3D 0;
> >>
> >
> > -- Is temp variable needed ?
>=20
> You tell me :)
>=20
> I just moved code around. I don't truly understand what it's doing.
> Maybe the read is needed for some kind of sync?
>=20
> I've removed the tlb flush all completely and I didn't notice any
> problems, is it really needed?
>=20
> --
> Felipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
