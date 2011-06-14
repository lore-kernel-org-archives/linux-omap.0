From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix wrong OMAP_ES_x_y defines that make
 omap_rev_lt_x_y and friends misbehave
Date: Tue, 14 Jun 2011 04:41:16 -0700
Message-ID: <20110614114116.GQ3352@atomide.com>
References: <BANLkTinWdQsjttt0m1h9KbVPjb6rWXNpvA@mail.gmail.com>
 <BANLkTi=75up6OQwRzGJ586eVLorEdpCa7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45552 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755872Ab1FNLlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:41:18 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=75up6OQwRzGJ586eVLorEdpCa7w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

* Tasslehoff Kjappfot <tasskjapp@gmail.com> [110614 03:35]:
> From 620fa271b32f8bdd8f06954c0a2c96af6ed1dc7b Mon Sep 17 00:00:00 200=
1
> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> Date: Tue, 14 Jun 2011 12:06:09 +0200
> Subject: [PATCH] Fix wrong OMAP_ES_x_y defines that make
> omap_rev_lt_x_y and friends misbehave

Hmm, we don't seem to have these in the mainline kernel?
Maybe take a look if something still needs to patched
there?

Tony

> ---
> =C2=A0arch/arm/plat-omap/include/plat/cpu.h | =C2=A0 =C2=A08 ++++----
> =C2=A01 files changed, 4 insertions(+), 4 deletions(-)
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
> b/arch/arm/plat-omap/include/plat/cpu.h
> index 7d24faa..ec63575 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -397,10 +397,10 @@ IS_OMAP_TYPE(3517, 0x3517)
> =C2=A0 * Silicon revisions
> =C2=A0 */
> =C2=A0#define OMAP_ES_1_0 0x00
> -#define OMAP_ES_2_0 0x10
> -#define OMAP_ES_2_1 0x20
> -#define OMAP_ES_3_0 0x30
> -#define OMAP_ES_3_1 0x40
> +#define OMAP_ES_2_0 0x01
> +#define OMAP_ES_2_1 0x02
> +#define OMAP_ES_3_0 0x03
> +#define OMAP_ES_3_1 0x04
>=20
> =C2=A0#define OMAP_REV_MASK 0x0000ff00
> =C2=A0#define OMAP_REV_BITS ((omap_rev() & OMAP_REV_MASK) >> 8)
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
