From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] omap1: Add omap1_defconfig
Date: Tue, 7 Dec 2010 18:00:19 -0800
Message-ID: <20101208020019.GO17435@atomide.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
 <20101204213657.32208.50997.stgit@baageli.muru.com>
 <AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61905 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145Ab0LHCAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 21:00:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [101207 04:28]:
> On Sat, Dec 4, 2010 at 11:36 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > The omap1_defconfig this should be eventually usable for booting
> > all omap1 machines. Generated based on:
> >
> > $ grep ARCH_OMAP1=3Dy arch/arm/configs/* | cut -d: -f1 | xargs cat =
| \
> > =C2=A0 =C2=A0 sort | uniq >> arch/arm/configs/omap1_defconfig
> >
> > Then change few things manually, like use Nokia 770 CONFIG_CMDLINE
> > as it does not allow setting it in the bootloader.
> >
> > After make oldconfig, ran reduce_defconfig python script on it
> > as posted by Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
:
>=20
> AFAIK you should use 'make savedefconfig'.

OK cool thanks for the tip. Updating the description for that
and also will take out CONFIG_DEBUG_DRIVER=3Dy as it's too noisy.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
