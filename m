From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/3] OMAP: DSS2: remove dummy panel driver duplicated
 panel drivers
Date: Tue, 2 Nov 2010 19:11:13 +0200
Message-ID: <AANLkTikXAmgxmA9eBqRceJuvMS+cNGk_NQo_R6TpcpQR@mail.gmail.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<1288714390-6159-3-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61720 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229Ab0KBRLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 13:11:14 -0400
Received: by vws13 with SMTP id 13so5246698vws.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 10:11:13 -0700 (PDT)
In-Reply-To: <1288714390-6159-3-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 2, 2010 at 6:13 PM, Bryan Wu <bryan.wu@canonical.com> wrote=
:
> Still keep sharp_ls_panel driver, because it contains blacklight cont=
rol driver.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 18 -
> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 -
> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0174 =
-------
> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0165 ------
> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0535 --=
------------------
> =A05 files changed, 0 insertions(+), 895 deletions(-)
> =A0delete mode 100644 drivers/video/omap2/displays/panel-generic.c
> =A0delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t=
1dg01.c
> =A0delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mte=
a1.c

Hey don't remove panel-tpo-td043mtea1.c, it's not a dupe! You probably
confused it with panel-toppoly-tdo35s.c . This shows you did not build
test all panel drivers, just select them all in config (enable SPI so
they all appear).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
