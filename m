From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 12:13:46 +0200
Message-ID: <1366280026.4085.55.camel@mars>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars>
	 <516FB845.3070505@ti.com>  <516FBB19.4090609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:55483 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967958Ab3DRKNw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 06:13:52 -0400
Received: by mail-bk0-f53.google.com with SMTP id e19so1195970bku.12
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 03:13:50 -0700 (PDT)
In-Reply-To: <516FBB19.4090609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Thu, 2013-04-18 at 12:21 +0300, Tomi Valkeinen wrote:
> On 2013-04-18 12:09, Tomi Valkeinen wrote:
> > On 2013-04-18 11:37, Christoph Fritz wrote:
>=20
> >> With linux-next this patch breaks compiling here because DPI now d=
epends
> >> on DSI - but my omap3 board here doesn't use DSI at all:
> >>
> >> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_c=
b=E2=80=99:
> >> drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of =
function =E2=80=98dsi_hsdiv_calc=E2=80=99
> >> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_ca=
lc=E2=80=99:
> >> drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of =
function =E2=80=98dsi_get_pll_clkin=E2=80=99
> >> drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of =
function =E2=80=98dsi_pll_calc=E2=80=99
> >>
> >> Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You =
may be want to merge it?
> >=20
> > Thanks for reporting this. We shouldn't make DPI depend on DSI. We
> > should make dummy functions for the above when DSI is not enabled s=
o
> > that DPI compiles. I'll make a fix.
>=20
> Patch below. Can you try it out? It works for me on Panda.

Thanks, it compiles here fine too.

and while booting I'm now getting as with 3.9-rc:
[    0.409729] OMAP DSS rev 2.0
[    0.410980] omapdss DPI error: can't get VDDS_DSI regulator
[    0.410980] omapdss DPI error: device ips-056t init failed: -517

But here with linux-next (in contrast to 3.9-rc) removing all regulator
dependencies from drivers/video/omap2/dss/dpi.c does not make the trick=
=2E
The display stays dark :-( ...

 Thanks
  -- Christoph

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
