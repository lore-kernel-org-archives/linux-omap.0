From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix omap2+ build error.
Date: Fri, 30 Mar 2012 14:19:33 +0530
Message-ID: <CAMQu2gyqXsft-DByeGYRt8V-gWB-8B8QJk55WLj5XyO+EMYYKw@mail.gmail.com>
References: <1333096516-4252-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:47606 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759611Ab2C3Ity convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 04:49:54 -0400
Received: by qatm19 with SMTP id m19so36306qat.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 01:49:53 -0700 (PDT)
In-Reply-To: <1333096516-4252-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Fri, Mar 30, 2012 at 2:05 PM, R Sricharan <r.sricharan@ti.com> wrote=
:
> With CONFIG_OMAP4_ERRATA_I688 enabled, omap2+ build
> was broken as below.
>
> =A0 =A0 =A0 =A0arch/arm/kernel/io.c: In function '_memcpy_toio':
> =A0 =A0 =A0 =A0arch/arm/kernel/io.c:29: error: implicit declaration o=
f function 'outer_sync'
> =A0 =A0 =A0 =A0make[1]: *** [arch/arm/kernel/io.o] Error 1
>
> Fixing this here.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/include/asm/barrier.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
Can you please add information about the commit
after this was broken.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
