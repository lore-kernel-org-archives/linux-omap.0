From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: TEMP: Round of the carve out memory
 requested to section_size
Date: Wed, 12 Sep 2012 14:12:32 +0530
Message-ID: <c524b899151fbbf9dedebe7f796bd59a@mail.gmail.com>
References: <1347429117-10919-1-git-send-email-r.sricharan@ti.com> <CAMQu2gxaamzm8i=ZcCU+99NnA6dDgi6H0GJwVtSmYWjPcyk5WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:53890 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034Ab2ILImf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 04:42:35 -0400
Received: by vbbff1 with SMTP id ff1so1739901vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 01:42:33 -0700 (PDT)
In-Reply-To: <CAMQu2gxaamzm8i=ZcCU+99NnA6dDgi6H0GJwVtSmYWjPcyk5WQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

[..]
> > memblock_steal tries to reserve physical memory during boot.
> > When the requested size is not aligned on the section size
> > then, the remaining memory available for lowmem becomes
> > unaligned on the section boundary. There is a issue with this,
> > which is discussed in the thread below.
> >
> > https://lkml.org/lkml/2012/6/28/112
> >
> > The final conclusion from the thread seems to
> > be align the memblock_steal calls on the SECTION boundary.
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Why is the TEMP in the subject line. From patch it doesn't be
> temporary version. Can you please clarify that ?
>
 Oops, that was a mistake. Reposted by correcting it.

Thanks,
 Sricharan
