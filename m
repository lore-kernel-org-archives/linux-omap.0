From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v2 2/2] omap3: beaglexm: fix DVI initialization
Date: Wed, 9 Feb 2011 04:37:26 +0430
Message-ID: <AANLkTimb928JK-4ZkbUZJjphPPcw47d4Fou0DV1y0epk@mail.gmail.com>
References: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com> <1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59828 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755828Ab1BIAII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Feb 2011 19:08:08 -0500
Received: by mail-yx0-f173.google.com with SMTP id 31so3064310yxl.18
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 16:08:06 -0800 (PST)
In-Reply-To: <1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 9, 2011 at 00:13, Ricardo Salveti de Araujo
<ricardo.salveti@canonical.com> wrote:
> Function beagle_twl_gpio_setup is called after beagle_display_init, w=
hat
> lets reset_gpio with an invalid value at the time it request the gpio=
=2E
> As a side effect the DVI reset GPIO is not properly set.
>
> Also removing old code that powers down DVI in a hardcoded way, as it=
's
> not necessary anymore.
>
> Tested with Beagle-xM and C4.
>
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.c=
om>

Reviewed-by: Charulatha V <charu@ti.com>

> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 22 +++++++++++------=
-----
> =A01 files changed, 11 insertions(+), 11 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
