From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] Remove old-style supply.dev assignments common in
 hsmmc init
Date: Mon, 6 Jun 2011 13:13:21 +0300
Message-ID: <BANLkTimgW+53CEfU8wNpaO8wPgWJ3yT90w@mail.gmail.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-3-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41582 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab1FFKNW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 06:13:22 -0400
Received: by vws1 with SMTP id 1so2623273vws.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 03:13:21 -0700 (PDT)
In-Reply-To: <1307342762-25363-3-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Felipe Balbi <balbi@ti.com>

On Mon, Jun 6, 2011 at 9:46 AM,  <green@linuxhacker.ru> wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
--
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 --
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0| =A0 =A04 ----
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 | =A0 =A04 --=
--
> =A0arch/arm/mach-omap2/board-omap3logic.c =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 | =A0 =A04 ----
> =A0arch/arm/mach-omap2/board-omap3touchbook.c =A0 | =A0 =A04 ----
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 --
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A07 -------
> =A09 files changed, 0 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2=
/board-cm-t35.c
> index 33855e4..a38cd70 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -480,8 +480,6 @@ static int cm_t35_twl_gpio_setup(struct device *d=
ev, unsigned gpio,
> =A0 =A0 =A0 =A0omap2_hsmmc_init(mmc);
>
> =A0 =A0 =A0 =A0/* link regulators to MMC adapters */

Would be useful to remove this comment too.

> - =A0 =A0 =A0 cm_t35_vmmc1_supply.dev =3D mmc[0].dev;
> - =A0 =A0 =A0 cm_t35_vsim_supply.dev =3D mmc[0].dev;
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
