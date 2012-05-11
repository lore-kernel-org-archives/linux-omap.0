From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Fri, 11 May 2012 12:57:45 -0600
Message-ID: <20120511185745.558333E0791@localhost>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com> <CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com> <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com> <1664819.7TVaX0jpJi@acer> <CAC83ZvKHDWmNneK5GQgSPhdg88apymEgUr0zm1EVYjfaWG2oXA@mail.gmail.com> <87mx5gm7wj.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38622 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2EKS5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 14:57:48 -0400
Received: by pbbrp8 with SMTP id rp8so3655233pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 11:57:48 -0700 (PDT)
In-Reply-To: <87mx5gm7wj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Thu, 10 May 2012 07:23:56 -0700, Kevin Hilman <khilman@ti.com> wrote:
> Grant,
> 
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
> 
> > Hi,
> >
> > On Thu, May 10, 2012 at 3:06 AM, Janusz Krzysztofik
> > <jkrzyszt@tis.icnet.pl> wrote:
> >> On Mon, 7 May 2012 10:52:28 DebBarma, Tarun Kanti wrote:
> >>> On Sun, May 6, 2012 at 3:25 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> >>> > On Mon, Apr 30, 2012 at 10:20 AM, Tarun Kanti DebBarma
> >>> > <tarun.kanti@ti.com> wrote:
> >>> >> Initialization of irqenable, irqstatus registers is the common
> >>> >> operation done in this function for all OMAP platforms, viz. OMAP1,
> >>> >> OMAP2+. The latter _gpio_rmw()'s which supposedly got introduced
> >>> >> wrongly to take care of OMAP2+ platforms were overwriting initially
> >>> >> programmed OMAP1 value breaking functionality on OMAP1.
> >>
> >> Hi,
> >> I can confirm that my other issues with GPIO on Amstrad Delta were not
> >> related, and this patch is still required for GPIO interrupts hardware
> >> being correctly initialized on OMAP1 in 3.4-rc6. You can add my
> >>
> >> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >>
> >> if you wish.
> > Thank you for confirming!!
> 
> We'd like to get this one in for v3.4-rc.  Can you queue it?
> 
> I added the tested-by from Janusz and my signoff, and pull request is
> below.

Pulled, thanks.  I'll send a pull req out to Linus today.

g.

