From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7] board-omap3-beagle: add DSS2 support
Date: Wed, 21 Apr 2010 13:06:36 +0300
Message-ID: <r2g94a0d4531004210306t11fee422i858f4854dd65d653@mail.gmail.com>
References: <1271844135-15810-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:60184 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0DUKGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 06:06:38 -0400
Received: by bwz25 with SMTP id 25so7879767bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 03:06:37 -0700 (PDT)
In-Reply-To: <1271844135-15810-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On Wed, Apr 21, 2010 at 1:02 PM, Koen Kooi <koen.kooi@gmail.com> wrote:
> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV=
-out are supported.
>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---

> @@ -456,8 +503,9 @@ static void __init omap3_beagle_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ensure SDRC pins are mux'd for self-ref=
resh */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mux_init_signal("sdrc_cke0", OMAP_PIN=
_OUTPUT);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mux_init_signal("sdrc_cke1", OMAP_PIN=
_OUTPUT);
> -}
>
> + =C2=A0 =C2=A0 =C2=A0 beagle_display_init();
> +}

Missing space here.

> =C2=A0static void __init omap3_beagle_map_io(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_set_globals_343x();
> --

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
