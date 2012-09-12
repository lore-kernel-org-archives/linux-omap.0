From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: TEMP: Round of the carve out memory
 requested to section_size
Date: Wed, 12 Sep 2012 11:28:22 +0530
Message-ID: <CAMQu2gxaamzm8i=ZcCU+99NnA6dDgi6H0GJwVtSmYWjPcyk5WQ@mail.gmail.com>
References: <1347429117-10919-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:48941 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab2ILF6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 01:58:48 -0400
Received: by weyx10 with SMTP id x10so698537wey.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 22:58:46 -0700 (PDT)
In-Reply-To: <1347429117-10919-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 11:21 AM, R Sricharan <r.sricharan@ti.com> wrote:
> memblock_steal tries to reserve physical memory during boot.
> When the requested size is not aligned on the section size
> then, the remaining memory available for lowmem becomes
> unaligned on the section boundary. There is a issue with this,
> which is discussed in the thread below.
>
> https://lkml.org/lkml/2012/6/28/112
>
> The final conclusion from the thread seems to
> be align the memblock_steal calls on the SECTION boundary.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
Why is the TEMP in the subject line. From patch it doesn't be
temporary version. Can you please clarify that ?

Regards
Santosh
