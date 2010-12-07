From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] omap1: Add omap1_defconfig
Date: Tue, 7 Dec 2010 14:38:19 +0200
Message-ID: <AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
	<20101204213657.32208.50997.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:34760 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0LGMiV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 07:38:21 -0500
Received: by bwz16 with SMTP id 16so11831440bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 04:38:19 -0800 (PST)
In-Reply-To: <20101204213657.32208.50997.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sat, Dec 4, 2010 at 11:36 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> The omap1_defconfig this should be eventually usable for booting
> all omap1 machines. Generated based on:
>
> $ grep ARCH_OMAP1=3Dy arch/arm/configs/* | cut -d: -f1 | xargs cat | =
\
> =C2=A0 =C2=A0 sort | uniq >> arch/arm/configs/omap1_defconfig
>
> Then change few things manually, like use Nokia 770 CONFIG_CMDLINE
> as it does not allow setting it in the bootloader.
>
> After make oldconfig, ran reduce_defconfig python script on it
> as posted by Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:

AFAIK you should use 'make savedefconfig'.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
