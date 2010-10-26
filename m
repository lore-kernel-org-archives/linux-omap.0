From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
Date: Tue, 26 Oct 2010 12:43:55 -0500
Message-ID: <AANLkTi=ZUPFqrTeLhuDKzkgU19RyMPD5DJ8kdJCyOXZz@mail.gmail.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33554 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760124Ab0JZRn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 13:43:56 -0400
Received: by wyf28 with SMTP id 28so4897790wyf.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 10:43:55 -0700 (PDT)
In-Reply-To: <AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 26, 2010 at 12:13 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> =A0arch/arm/plat-omap/include/plat/iva2_dsp.h =A0 =A0| =A0 56 ++++++=
+++++++++++++++++++
>
> Why not use the already existing dsp.h?

Good point, I guess when the patch was made dsp.h didn't exist, but
since the user of those defines is pm34xx.c too, including it in dsp.h
would include the declaration of everything inside dsp.h; however I
don't see that as an impediment for dma.h or gpmc.h to be included.

Regards,
Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
