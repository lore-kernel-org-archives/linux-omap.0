From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC][PATCH 0/19] Cleanup- custom error codes
Date: Fri, 26 Mar 2010 00:08:16 +0200
Message-ID: <94a0d4531003251508u1cd3d5f6l85636213b239b9bb@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBEB1C@dbde02.ent.ti.com>
	 <4BABCE66.7080304@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044DEBEB3B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62678 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0CYWIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 18:08:18 -0400
Received: by bwz1 with SMTP id 1so1327623bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Mar 2010 15:08:16 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBEB3B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

On Thu, Mar 25, 2010 at 11:37 PM, Hebbar, Shivananda <x0hebbar@ti.com> =
wrote:
>> love the cleanup *but*:
>> arch/arm/plat-omap/include/dspbridge/dbdefs.h:typedef u32 dsp_status=
;
>> 1) All usage of dsp_status should be changed to int
>
> Looks like MM code uses this variable. Even MM code needs to be chang=
ed for this. But changes are minimal.

What do you mean by MM uses this variable? If you mean user-space
(omx, gst-dsp), then no, error codes are passed through ioctl, which
returns an int.

And anyway on 32bit dsp_status =3D u32 =3D int.

>> 2) You should be using -Exxxx instead of Exxxxx in all the patches.
> =C2=A0Ok!!

Yeah, otherwise DSP_FAILED will fail.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
