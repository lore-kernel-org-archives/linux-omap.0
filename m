From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] OMAPDSS: TPO-TD03MTEA1: Correct comment for power on delay
Date: Mon, 19 Mar 2012 18:06:19 +0200
Message-ID: <CANOLnOOy=cGDhR+EVWfQWTsMPctk_OmPZO=w43E3yT3YM9Z6gQ@mail.gmail.com>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1332169352-5076-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49807 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745Ab2CSQGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:06:19 -0400
In-Reply-To: <1332169352-5076-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Mar 19, 2012 at 5:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Since any power on stabilisation delay for the supply itself should b=
e
> taken care of transparently by the regulator API when the regulator i=
s
> enabled the additional delay that the TPO-TD03MTEA1 driver adds after
> that returned should be due to the requirements of the device itself
> rather than the supply (the delay is also suspicously long for one fo=
r
> a regulator to ramp).

True, it came from panel's datasheet which asks to wait for ">10ms + 7
vsyncs" after tuning on the supply and before switching the control
signal.

> Correct the comment to avoid misleading people
> taking this code as a reference.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =C2=A0.../video/omap2/displays/panel-tpo-td043mtea1.c =C2=A0 =C2=A0| =
=C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)

=46WIW:
Acked-by: Grazvydas Ignotas <notasas@gmail.com>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
