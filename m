From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Mon, 19 Dec 2011 16:04:53 +0200
Message-ID: <4EEF4485.8050809@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com> <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com> <20111214095745.GD3072@opensource.wolfsonmicro.com> <3652535.KtFJC1aH5Z@barack> <20111217093645.GH2833@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47320 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab1LSOE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 09:04:58 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id p5so2170352lag.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 06:04:56 -0800 (PST)
In-Reply-To: <20111217093645.GH2833@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi Mark, Tony,

On 12/17/2011 11:36 AM, Mark Brown wrote:
>> Yes this is planed for the Dtree support, but the aim here is to get=
 working=20
>> audio on PandaBoard as well with upstream kernel.
>=20
> Just do it right to start off with, the device tree bindings should
> normally map closely onto the platform data where platform data exist=
s
> already and you're going to have to have the code structured by featu=
re
> anyway.

I do not want to 'bloat' the board files under mach-omap2 for sdp4430,
Panda with string arrays to pass the DAPM routing from there to the ASo=
C
machine driver to construct the board specific routing.
All of this sort of thing will go away with DT in the future (including
the platform_data).

I planed to do this similar way as it is done for the tegra_wm8903.c
machine driver:
- without DT blob we support only sdp4430, Panda boards
- with DT we will have similar mapping as tegra is planning to have.

If Tony is fine to add text array constructed under mach-omap2 which
describes the ASoC DAPM mapping, I can do it, but AFAIK we should
minimize the code size in that part of the kernel.

To pass the routing from the board files I need to modify the platform_=
data:

struct omap-abe-twl6040-connection {
	const char *sink;
	const char *source;
};

struct omap_abe_twl6040_data {
	char *card_name;
	enum board_type board;
	struct omap-abe-twl6040-connection *route;
	int num_of_routes;
};

In board files:
struct omap-abe-twl6040-connection sdp4430_asoc_route[] =3D {
	{"MAINMIC", "Main Mic Bias"},
	{"SUBMIC", "Main Mic Bias"},
	{"Main Mic Bias", "Ext Mic"},
	...
	16 string pair.
}

If this is acceptable by Tony, I can do this.

To describe the routing via feature flags is not really practical due t=
o
the possible variation I can think of.

Tony: what do you think? Is this something that is allowed to do under
plat-omap2?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
