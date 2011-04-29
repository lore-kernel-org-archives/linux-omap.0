From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/8] staging: tidspbridge: PM routines cleanup
Date: Fri, 29 Apr 2011 14:20:22 -0500
Message-ID: <BANLkTi=U2X=ouF-vdqHRK9k0VALDmSYaSA@mail.gmail.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35944 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759221Ab1D2TUY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 15:20:24 -0400
Received: by mail-wy0-f179.google.com with SMTP id 36so3430620wyg.38
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 12:20:22 -0700 (PDT)
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Wed, Mar 23, 2011 at 1:49 PM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Cleanup and fixes for tidspbridge's PM routines.
>
> The most significant ones are:
> - Protection of critical sections when disabling clocks which
> =A0could cause issues during PM transitions.
> - Fix of resume path from RET power state.
>
> Other patches are cleanups and preparations for the usage of
> spinlock.
>
> Omar Ramirez Luna (8):
> =A0staging: tidspbridge: make wake_dsp to handle PM code
> =A0staging: tidspbridge: fix resume path from retention
> =A0staging: tidspbridge: remove msleep for dsp transition wait
> =A0staging: tidspbridge: send mbox PM command directly
> =A0staging: tidspbridge: send wake message even if dsp is running
> =A0staging: tidspbridge: remove redundant code from PM routines
> =A0staging: tidspbridge: remove redundant indentation in PM routines
> =A0staging: tidspbridge: protect critical sections on PM routines
>
> =A0drivers/staging/tidspbridge/core/tiomap3430_pwr.c | =A0248 +++++++=
+++++++-------
> =A0drivers/staging/tidspbridge/core/tiomap_io.c =A0 =A0 =A0| =A0 58 +=
-----
> =A02 files changed, 168 insertions(+), 138 deletions(-)

Pushed to dspbridge.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
