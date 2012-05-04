From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: dma: Define dma capabilities register
 bitfields and use them.
Date: Fri, 4 May 2012 13:02:48 +0530
Message-ID: <CAMQu2gzDgPQwrv4oRCeUKEeYq4Tpu=X=SBSFjKzeTb7TzDsb9A@mail.gmail.com>
References: <1336116582-11099-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:44443 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368Ab2EDHdK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 03:33:10 -0400
Received: by qadz3 with SMTP id z3so936426qad.17
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 00:33:08 -0700 (PDT)
In-Reply-To: <1336116582-11099-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 4, 2012 at 12:59 PM, R Sricharan <r.sricharan@ti.com> wrote=
:
> The system dma module has capabiities register indicating
> the support for descriptor loading, constant fill, etc.
> Use this instead of OMAP revision check to identify the features
> supported runtime.
>
> This avoids patching the code for feature SOCs which has
> those capabilities.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> ---
> =A0arch/arm/mach-omap2/dma.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +++++++=
----
> =A0arch/arm/plat-omap/include/plat/dma.h | =A0 =A05 +++++
> =A02 files changed, 12 insertions(+), 4 deletions(-)
>
Looks fine. Will add it to my clean-up series if no has
any objection on the patch.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
