From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make
 board_onenand_init() visible to board code
Date: Tue, 8 May 2012 16:16:54 -0700
Message-ID: <20120508231653.GP5088@atomide.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12379 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2EHXQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:16:57 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

* Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb=C3=B2 i Serra
> <eballetbo@gmail.com> wrote:
> >
> > Tony, as this is a fix ,may be included ?
> >
> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >
> > Cheers,
> > =C2=A0 =C2=A0Enric
>=20
> Hi Tony, Russel:
>=20
> This patch is a requirement for patch:
>=20
> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
> storage memory
>=20
> which is really important since newer IGEPv2 boards have changed thei=
r
> flash memory from OneNAND to NAND.
>=20
> This patch-set is necessary to make the board work, otherwise it
> doesn't even boot.
>=20
> Could we please include these patches?

Thanks for the patience, applying now into board branch finally.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
