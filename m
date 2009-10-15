From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg access
Date: Thu, 15 Oct 2009 10:25:30 +0300
Message-ID: <200910151025.30493.peter.ujfalusi@nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF74A@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB9@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CDA1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20099 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbZJOH1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 03:27:07 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CDA1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Varadarajan, Charu Latha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

On Thursday 15 October 2009 09:10:54 ext Shilimkar, Santosh wrote:
> > > > > > -   writew(buf, base + OMAP_MCBSP_REG_DXR1);
> > > > > > +   OMAP_MCBSP_WRITE(base, DXR, buf);
> > > > >
> > > > > Why do you need this? Is writew()/readw() not doing 16 bit
> > > > > operations  ?
> > > >
> > > > The intension is to use 32 bit access and not 16 bit access
> > >
> > > Use readl() / writel() then.
> >
> > Yes,  OMAP_MCBSP_WRITE macro makes use of readl() / writel() for OM=
AP3
>=20
> Good!! Then get rid of this macro and directly use kernel standard
>  API-	readl() / writel() --

Well, OMAP1 and OMAP2 still has 16 bit registers in McBSP.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
