From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Fri, 11 May 2012 12:58:33 -0600
Message-ID: <20120511185834.08DAB3E0791@localhost>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com> <CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com> <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51049 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab2EKS6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 14:58:36 -0400
Received: by dady13 with SMTP id y13so3447875dad.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 11:58:36 -0700 (PDT)
In-Reply-To: <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

On Mon, 7 May 2012 10:52:28 +0530, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> wrote:
> Hi,
> 
> On Sun, May 6, 2012 at 3:25 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > I've noticed that current mainline enables _all_ possible GPIO
> > interrupts, this patch fixes that problem.
> OK, thanks.
> 
> > Also Grant doesn't seem to be on CC so might not be able to pick this up.
> I have added Cc: in the patch and was expecting that would take care.
> Looks like that has not happened. Anyways, I have explicitly added in the email.

I'm particularly bursty when it comes to patch review and applying.
Sometimes it takes me a while to find time for maintainership work.

g.

