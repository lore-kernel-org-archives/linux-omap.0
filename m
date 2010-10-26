From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/3] tidspbridge: convert OMAP3430 adaptation layer to use
 new SCM DSP boot control fns
Date: Tue, 26 Oct 2010 09:00:21 -0500
Message-ID: <AANLkTi=A5JVUnJKuyOh4vGfZ=Xnb60sUeE=_-NOOW3pp@mail.gmail.com>
References: <1287795901-28613-1-git-send-email-omar.ramirez@ti.com>
	<1287795901-28613-3-git-send-email-omar.ramirez@ti.com>
	<alpine.DEB.2.00.1010252339340.12449@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0JZOAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 10:00:23 -0400
Received: by wwe15 with SMTP id 15so4775999wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 07:00:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010252339340.12449@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, fernando.lugo@ti.com

On Tue, Oct 26, 2010 at 12:43 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> =A0arch/arm/mach-omap2/dsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 ++++
>> =A0arch/arm/plat-omap/include/plat/dsp.h =A0 =A0 =A0 =A0 | =A0 =A04 =
++++
>> =A0drivers/staging/tidspbridge/core/tiomap3430.c | =A0 13 ++++++----=
---
>
> Could you please split the tiomap3430.c change into a separate patch?
> That should go in via the staging tree once this series is accepted.

No problem.

Regards,
Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
