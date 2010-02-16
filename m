From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Tue, 16 Feb 2010 19:47:23 +0200
Message-ID: <94a0d4531002160947m863bfbepf46cd962e7753b42@mail.gmail.com>
References: <018f9cad9a346b7a841268f4520a73a98c9cf7c9.1266246072.git.ameya.palande@nokia.com>
	 <20100215155958.GA5458@annwn.felipec.org>
	 <1266323923.3092.14.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f200.google.com ([209.85.221.200]:35473 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab0BPRrZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 12:47:25 -0500
Received: by qyk38 with SMTP id 38so1340494qyk.1
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 09:47:24 -0800 (PST)
In-Reply-To: <1266323923.3092.14.camel@sanganak>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "x0095840@ti.com" <x0095840@ti.com>

Hi,

On Tue, Feb 16, 2010 at 2:38 PM, Ameya Palande <ameya.palande@nokia.com=
> wrote:
> Hi Felipe,
>
> On Mon, 2010-02-15 at 16:59 +0100, Contreras Felipe (Nokia-D/Helsinki=
)
> wrote:
>> On Mon, Feb 15, 2010 at 04:36:31PM +0100, Ameya Palande wrote:
>> > --- a/drivers/dsp/bridge/rmgr/drv.c
>> > +++ b/drivers/dsp/bridge/rmgr/drv.c
>> > @@ -273,11 +273,14 @@ DSP_STATUS =C2=A0DRV_ProcFreeDMMRes(HANDLE h=
PCtxt)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pDMMList =3D pDMMList->n=
ext;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pDMMRes->dmmAllocate=
d) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 status =3D PROC_UnMap(pDMMRes->hProcessor,
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)pDMMRes->ulDSPResAddr, pCtxt);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)pDMMRes->ulDSPAddr, pCtxt);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* PROC_UnMap has freed pDMMRes pointer, so don't access
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* it now
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/
>>
>> I don't see the need for this comment on the code.
>
> In above code segment, just by looking at PROC_Unmap() it is not
> apparent that it will deallocate "pDMMRes" thats why that comment is
> present there! I guess this whole memory corruption could have been
> easily avoided by presence of that comment ;)

Then the comment should be on PROC_Unmap() I guess.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
