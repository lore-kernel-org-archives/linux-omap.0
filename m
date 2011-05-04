From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH 1/7] OMAP: OMAPFB: Remove unused lcd drivers
Date: Wed, 4 May 2011 05:44:48 -0700
Message-ID: <BANLkTimuWoCFtq62mP2KF52VLytwqaWFzw@mail.gmail.com>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
	<1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39697 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab1EDMou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 08:44:50 -0400
In-Reply-To: <1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Arun C <arunedarath@mistralsolutions.com>, Koen Kooi <koen@openembedded.org>

On Wed, May 4, 2011 at 5:27 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> drivers/video/omap/ contains some lcd drivers which are not used by any
> board. They can be removed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Arun C <arunedarath@mistralsolutions.com>
> Cc: Koen Kooi <koen@openembedded.org>
> Cc: Steve Sakoman <steve@sakoman.com>
> ---
>  drivers/video/omap/Makefile          |    4 -
>  drivers/video/omap/lcd_omap2evm.c    |  192 ---------------------------------
>  drivers/video/omap/lcd_omap3beagle.c |  130 -----------------------
>  drivers/video/omap/lcd_omap3evm.c    |  193 ----------------------------------
>  drivers/video/omap/lcd_overo.c       |  180 -------------------------------
>  5 files changed, 0 insertions(+), 699 deletions(-)
>  delete mode 100644 drivers/video/omap/lcd_omap2evm.c
>  delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
>  delete mode 100644 drivers/video/omap/lcd_omap3evm.c
>  delete mode 100644 drivers/video/omap/lcd_overo.c

Acked-by: Steve Sakoman <steve@sakoman.com>

Steve
