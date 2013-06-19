From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Wed, 19 Jun 2013 10:48:26 +0100
Message-ID: <20130619094826.GE22998@laptop>
References: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
 <20130619082633.GB22998@laptop>
 <20130619083022.GU7161@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33334 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934059Ab3FSJsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 05:48:32 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so3108340eei.41
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 02:48:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130619083022.GU7161@zurbaran>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, ldewangan@nvidia.com, gg@slimlogic.co.uk

On Wed, 19 Jun 2013, Samuel Ortiz wrote:

> Hi Lee,
>=20
> On Wed, Jun 19, 2013 at 09:26:33AM +0100, Lee Jones wrote:
> > On Mon, 17 Jun 2013, J Keerthy wrote:
> >=20
> > > Remove code which is not necessary for a device tree boot.
> >=20
> > So we're exclusively DT now right?
> >=20
> > > Boot tested on OMAP5-UEVM board.
> > >=20
> > > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > > ---
> > >  drivers/mfd/palmas.c |  106 ------------------------------------=
--------------
> > >  1 files changed, 0 insertions(+), 106 deletions(-)
> >=20
> > If that's the case, applied with all Acks, thanks.
> It's already in mfd-next.

I noticed. Odd that I didn't receive you applied message.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
