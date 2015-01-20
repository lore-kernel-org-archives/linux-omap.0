From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/7] mfd: menelaus: make vcore and regulator controls
 internal
Date: Tue, 20 Jan 2015 14:01:43 +0000
Message-ID: <20150120140143.GQ13701@x1>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-7-git-send-email-aaro.koskinen@iki.fi>
 <20150120135840.GO13701@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44418 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbATOB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 09:01:56 -0500
Received: by mail-ig0-f177.google.com with SMTP id h15so8875905igd.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2015 06:01:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150120135840.GO13701@x1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 20 Jan 2015, Lee Jones wrote:

> On Sat, 27 Dec 2014, Aaro Koskinen wrote:
>=20
> > Make vcore and regulator control functions internal to the driver.
> >=20
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/mfd/menelaus.c       | 13 +++++++++++--
> >  include/linux/mfd/menelaus.h | 12 ------------
> >  2 files changed, 11 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> > index 4a900cc..8660adf 100644
> > --- a/drivers/mfd/menelaus.c
> > +++ b/drivers/mfd/menelaus.c
> > @@ -163,6 +163,15 @@
> >  #define MCT_PIN_ST_S1_CD_ST		(1 << 0)
> >  #define MCT_PIN_ST_S2_CD_ST		(1 << 1)
> > =20
> > +#define EN_VPLL_SLEEP			(1 << 7)
> > +#define EN_VMMC_SLEEP			(1 << 6)
> > +#define EN_VAUX_SLEEP			(1 << 5)
> > +#define EN_VIO_SLEEP			(1 << 4)
> > +#define EN_VMEM_SLEEP			(1 << 3)
> > +#define EN_DC3_SLEEP			(1 << 2)
> > +#define EN_DC2_SLEEP			(1 << 1)
> > +#define EN_VC_SLEEP			(1 << 0)
>=20
> Better to use the BIT() macro for this kind of stuff.
>=20
> Please take this opportunity to use it.

In fact, nevermind.  I'll do it from here.

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
