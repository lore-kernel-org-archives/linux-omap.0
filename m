From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
Date: Tue, 24 Mar 2009 06:48:11 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2349A31B@dlee03.ent.ti.com>
References: <Acmr6BM18BJBh1pxS8i5e+utnLzXGw==>
	 <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com>
 <269694c00903240304y69f43451lb260951167fe64af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60491 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbZCXLsU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 07:48:20 -0400
In-Reply-To: <269694c00903240304y69f43451lb260951167fe64af@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Amey,

> I am trying to understand this patch.
> I see that pCtxtclosed is passed to DRV_RemoveProcContext() function
> but it is not used anywhere inside it. I was expecting to see a
> statement there which should free its memory.

This pointer is getting freed indirectly through the pCtxt2 pointer. Th=
e call to the function "DRV_GetProcContext((u32)hProcess, hDRVObject, &=
pCtxt2, NULL, 0)" returns pCtxt2, which is same as pCtxtclosed that is =
passed to this function.
In a way, the call to DRV_GetProcContext is kind of redundant, but I th=
ink it is present here to provide the support to extract the Process Co=
ntext when only the PID is passed in.=20

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Ameya Palande [mailto:2ameya@gmail.com]
> Sent: Tuesday, March 24, 2009 5:05 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
>=20
> Hi Hari,
>=20
> On Mon, Mar 23, 2009 at 8:49 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRV_RemoveProcContext((struct DRV_OB=
JECT *)hDrvObject,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pCtxtclosed, (void *)pCtxtclosed-
> >pid);
>=20
> I am trying to understand this patch.
> I see that pCtxtclosed is passed to DRV_RemoveProcContext() function
> but it is not used anywhere inside it. I was expecting to see a
> statement there which should free its memory.
>=20
> Any pointers?
>=20
> Cheers,
> Ameya.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
