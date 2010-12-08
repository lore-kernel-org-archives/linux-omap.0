From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH RESEND] ARM: io: fix namespace conflicts
Date: Wed, 8 Dec 2010 18:03:02 +0530
Message-ID: <AANLkTi=Zbqb2nGCJmh-8r83S9j4DgxjKfZW6eEL-Un9c@mail.gmail.com>
References: <1291358089-10490-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33189 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753862Ab0LHMdn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 07:33:43 -0500
Received: by mail-iw0-f175.google.com with SMTP id 8so1710143iwn.6
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 04:33:42 -0800 (PST)
In-Reply-To: <1291358089-10490-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Russell,

On Fri, Dec 3, 2010 at 12:04, Sourav Poddar <sourav.poddar@ti.com> wrot=
e:
> Having __v as the variable name for the definition of different macro=
s leads
> to the namespace pollution. For example,
> readl(p)
> unrolls to:
> ({ u32 __v =3D ({ u32 __v =3D (( __u32)(__le32)(( __le32) ((void)0,
> *(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("m=
cr
> p15,
> , %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });
>
> ({ u32 __v =3D ({ u32 __v
> causes sparse warning: "warning: symbol '__v' shadows an earlier one"
>
> Using variable names which use the function name prefix across the
> various macros avoids the namespace pollution.
>
> With this change, ~200 sparse warnings in omap2plus_defconfig build a=
re
> fixed.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed by: Nishanth Menon <nm@ti.com>
> ---
> Links related to previous discussions are as follows:
> https://patchwork.kernel.org/patch/250171/
> http://www.spinics.net/lists/linux-omap/msg38569.html
> http://marc.info/?t=3D128506336700011&r=3D1&w=3D2
>
> arch/arm/include/asm/io.h | =A0 32 +++++++++++++++++++++-----------
> =A01 files changed, 21 insertions(+), 11 deletions(-)
>

If no comments, pls ack this patch.

Thanks,
V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
