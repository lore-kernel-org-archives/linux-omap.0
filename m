From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] DSPBRIDGE: Freeing allocated resources on rmmod
Date: Fri, 5 Dec 2008 01:38:32 -0800
Message-ID: <200812050138.33606.david-b@pacbell.net>
References: <27F9C60D11D683428E133F85D2BB4A5303F1E9A961@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:43545 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751488AbYLEJig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 04:38:36 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5303F1E9A961@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Thursday 04 December 2008, Ramirez Luna, Omar wrote:
> +=A0=A0=A0=A0=A0=A0=A0DSP_STATUS dsp_status =3D DSP_SOK;
> +=A0=A0=A0=A0=A0=A0=A0HANDLE=A0=A0 =A0 =A0 hDrvObject =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT=A0=A0*pTmp =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT =A0 =A0*pCtxtclosed =3D =
NULL;
> +=A0=A0=A0=A0=A0=A0=A0struct PROCESS_CONTEXT =A0 =A0*pCtxttraverse =3D=
 NULL;

It WoUlD bE a LoT nIcEr ...

=2E.. if new code didn't introduce new CamelCase usage,
and didn't use Hungarian notation.

Hungarian notation makes some sense in assembly language,
where it was created to help cope with the lack of typing.
But not in C.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
