From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 16:07:50 +0300
Message-ID: <200910081607.50375.peter.ujfalusi@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com> <1255005029.30157.164.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27445 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158AbZJHNJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:09:34 -0400
In-Reply-To: <1255005029.30157.164.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thursday 08 October 2009 15:30:29 Nurkkala Eero.An (EXT-Offcode/Oulu=
) wrote:
> On Thu, 2009-10-08 at 13:58 +0200, Valentin Eduardo (Nokia-D/Helsinki=
)
>=20
> wrote:
> > +/*
> > + * TPA6130 volume. From -59.5 to 4 dB with increasing step size wh=
en
> > going + * down in gain. Justify scale so that it is quite correct f=
rom
> > -20 dB and + * up. This setting shows -30 dB at minimum, -12.95 dB =
at 49
> > % (actual + * is -10.3 dB) and 4.65 dB at maximum (actual is 4 dB).
> > + */
>=20
> The comment is misleading from all it says. For me it seems that the
> scale is quite correct from -59.5 to 4 dB or so. Also the minimum is
> -59.5 dB, not -30.

Yes, the scale is really close to the reality, the comment need to be f=
ixed.=20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
