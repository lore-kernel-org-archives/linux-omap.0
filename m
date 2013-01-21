From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] Fix audio on Nokia RX-51
Date: Mon, 21 Jan 2013 10:14:37 +0100
Message-ID: <50FD06FD.9080007@ti.com>
References: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56996 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab3AUJOw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 04:14:52 -0500
In-Reply-To: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 01/20/2013 04:04 AM, Pali Roh=C3=A1r wrote:
> This patch series updating rx51 sound driver, using snd_soc_register_=
card,
> adding module alias for autoloading kernel driver and registring soun=
d
> driver in rx51 board code.
>=20
> Pali Roh=C3=A1r (2):
>   ASoC: omap: rx51: Use snd_soc_register_card and add module alias fo=
r
>     autoloading driver
>   ARM: OMAP: rx51: Register audio device

Can you reverse the order of the patches so we will avoid to have non w=
orking
audio between the two patch?

>=20
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   11 ++++++
>  sound/soc/omap/rx51.c                        |   50 +++++++++++++++-=
----------
>  2 files changed, 41 insertions(+), 20 deletions(-)
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
