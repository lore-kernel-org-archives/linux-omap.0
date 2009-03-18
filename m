From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 1/3] tidspbridge: don't flood the mailbox on MemUnMap
Date: Wed, 18 Mar 2009 15:29:44 +0200
Message-ID: <94a0d4530903180629q5e410a4agebbf07266c5814dd@mail.gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23320B48@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14067 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758279AbZCRN3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 09:29:47 -0400
Received: by fg-out-1718.google.com with SMTP id 13so95792fge.17
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 06:29:44 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E23320B48@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Wed, Mar 18, 2009 at 3:06 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> Felipe,
>
>> Check the hardware state of the DSP before sending the command to wa=
ke
>> it up thus avoiding to flood the mailbox unnecessarily.
>>
> -- So this check was missing in Unmap part. Good catch.
>
>
>> - =C2=A0 =C2=A0 u32 temp =3D 0;
>> - =C2=A0 =C2=A0 struct CFG_HOSTRES resources;
>> =C2=A0 =C2=A0 =C2=A0 u32 *pPhysAddrPageTbl =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 struct vm_area_struct *vma;
>> =C2=A0 =C2=A0 =C2=A0 struct mm_struct *mm =3D current->mm;
>> + =C2=A0 =C2=A0 u32 temp =3D 0;
>>
>
> -- Is temp variable needed ?

You tell me :)

I just moved code around. I don't truly understand what it's doing.
Maybe the read is needed for some kind of sync?

I've removed the tlb flush all completely and I didn't notice any
problems, is it really needed?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
