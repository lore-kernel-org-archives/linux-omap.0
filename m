From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 00/14] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Fri, 6 Jul 2012 18:17:43 +0530
Message-ID: <CAMQu2gxJkQoOUK3sn78e8BZ9fZx4jxS4YOdV_VBrAygSU1fAnA@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com> <20120706123611.GW1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42367 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab2GFMsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:48:05 -0400
Received: by qcsu28 with SMTP id u28so6111280qcs.22
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 05:48:03 -0700 (PDT)
In-Reply-To: <20120706123611.GW1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Jul 6, 2012 at 6:06 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120706 02:26]:
> > Tony,
> >
> > Here is the updated series with suggested corrections and generated
> > against
> > the latest cleanup-part2 at commit ae6df418. The series adds minimal
> > OMAP5
> > support. OMAP5430 has a dual core Cortex-A15 based MPU subsystem with
> > 2MB
> > L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and hence
> > large part of the peripherals are re-used.
>
> Looking good to me, just one cosmetic comment below:
>
Great.

> >   ARM: OMAP: counter-32k: Select the CR register offset using the IP
> > scheme.
> >   ARM: OMAP5: l3: Add l3 error handler support for omap5.
> >   ARM: omap2+: board-generic: clean up the irq data from board file.
> >   ARM: OMAP5: board-generic: Add device tree support.
> >   ARM: OMAP5: Add SMP support.
>
> Can you please remove the trailing period from the patch title lines?
> That's not typically used..
>
I agree. Fixed it and update the branch.

Regards,
Santosh
