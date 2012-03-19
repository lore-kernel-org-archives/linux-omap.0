From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/2] OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
Date: Mon, 19 Mar 2012 18:01:56 +0200
Message-ID: <CANOLnOM2tuDLsJAp_D3tX6dG_9Kq2xr8+p9C=o4dHR8Q1f91hQ@mail.gmail.com>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54591 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab2CSQB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:01:56 -0400
In-Reply-To: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Mar 19, 2012 at 5:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It is possible for regulator_enable() to fail and if it does fail tha=
t's
> generally a bad sign for anything we try to do with the hardware afte=
rwards
> so check for and immediately return an error if regulator_enable() fa=
ils.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =C2=A0.../video/omap2/displays/panel-tpo-td043mtea1.c =C2=A0 =C2=A0| =
=C2=A0 =C2=A05 ++++-
> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>

=46WIW:
Acked-by: Grazvydas Ignotas <notasas@gmail.com>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
