From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: Freeing allocated resources
 on rmmod
Date: Fri, 5 Dec 2008 10:42:47 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1E9AA94@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5303F1E9A961@dlee03.ent.ti.com>
 <200812050138.33606.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbYLEQnE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 11:43:04 -0500
In-Reply-To: <200812050138.33606.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>


Hi David,

>From: David Brownell [mailto:david-b@pacbell.net]
>Sent: Friday, December 05, 2008 3:39 AM
>To: Ramirez Luna, Omar
>Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Gupta, Ramesh; Kanigeri,=
 Hari
>Subject: Re: [linux-omap] [PATCH 2/2] DSPBRIDGE: Freeing allocated
>resources on rmmod
>
>On Thursday 04 December 2008, Ramirez Luna, Omar wrote:
>> +=A0=A0=A0=A0=A0=A0=A0DSP_STATUS dsp_status =3D DSP_SOK;
>> +=A0=A0=A0=A0=A0=A0=A0HANDLE=A0=A0 =A0 =A0 hDrvObject =3D NULL;
>> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT=A0=A0*pTmp =3D NULL;
>> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT =A0 =A0*pCtxtclosed =3D=
 NULL;
>> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT =A0 =A0*pCtxttraverse =3D=
 NULL;
>
>It WoUlD bE a LoT nIcEr ...
>
>... if new code didn't introduce new CamelCase usage,
>and didn't use Hungarian notation.
>
>Hungarian notation makes some sense in assembly language,
>where it was created to help cope with the lack of typing.
>But not in C.

Thanks for your comments and time, we are still working towards meeting=
 open source standards and enhancing the code with all the feedback rec=
eived (RW, RMK, TL, HD, FC and many more people) to get the driver push=
ed a piece at a time.

There are still action items in our list, along with coding style, but =
we'll keep working to get them done.

- omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
