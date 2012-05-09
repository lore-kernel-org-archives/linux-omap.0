From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Wed, 09 May 2012 23:36:09 +0200
Message-ID: <1664819.7TVaX0jpJi@acer>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com> <CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com> <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41786 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440Ab2EIVir (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:38:47 -0400
In-Reply-To: <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Mon, 7 May 2012 10:52:28 DebBarma, Tarun Kanti wrote:
> On Sun, May 6, 2012 at 3:25 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > On Mon, Apr 30, 2012 at 10:20 AM, Tarun Kanti DebBarma
> > <tarun.kanti@ti.com> wrote:
> >> Initialization of irqenable, irqstatus registers is the common
> >> operation done in this function for all OMAP platforms, viz. OMAP1,
> >> OMAP2+. The latter _gpio_rmw()'s which supposedly got introduced
> >> wrongly to take care of OMAP2+ platforms were overwriting initially
> >> programmed OMAP1 value breaking functionality on OMAP1.

Hi,
I can confirm that my other issues with GPIO on Amstrad Delta were not 
related, and this patch is still required for GPIO interrupts hardware 
being correctly initialized on OMAP1 in 3.4-rc6. You can add my

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

if you wish.

Thanks,
Janusz
