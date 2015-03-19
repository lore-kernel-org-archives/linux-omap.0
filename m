From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 14:56:35 +0200
Message-ID: <550AC783.8040304@ti.com>
References: <1426741659.10003.9.camel@midgaarde>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48982 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbbCSM4u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 08:56:50 -0400
In-Reply-To: <1426741659.10003.9.camel@midgaarde>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 03/19/2015 07:07 AM, Greg Knight wrote:
> Hi, Mark, Jaroslav,
>=20
> I've attached a couple patches to provide support for the Freescale
> SGTL5000 chip when using the McASP on the AM3359.

It is more correct to say that this is needed in a custom hardware whic=
h uses
McASP and SGTL5000 codec.

> This adds an optional hack, "clock-to-talk" to the McASP subsystem wh=
ich
> can start AHCLKX/AHCLKR prior to initializing the codec. This is need=
ed
> on the SGTL5000, which depends on AHCLKX for its master clock.

SO is it so that the codec's MCLK is coming from McASP AHCLKX (or R) an=
d this
clock need to be present all the time? W/o the MCLK the registers are n=
ot
accessible?

> These patches are based off of 3.14.31-ti-r49. What is the process fo=
r
> getting these merged?

=46irst off, please send the patches with git send-email so people can =
comment
on them.

This will not work in mainline kernel. The McASP is turned off when it =
is not
in use (no audio activity) so the AHCLKX/R is not going to be there on =
the
ball output.

How do you configure the frequency of the AHCLKX/R, this hack only enab=
les it,
so you are going to have _some_ clock going out.

You should be using set_clkdiv and set_sysclk calls from the machine dr=
iver to
configure the AHCLKX (we do not have AHCLKR supported in the driver ATM=
).

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
