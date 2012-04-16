From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 13:29:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204161328130.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-3-git-send-email-tarun.kanti@ti.com> <alpine.DEB.2.00.1204161049250.29048@utopia.booyaka.com> <CAC83ZvKRMfP7xqmPLCwQWwTWxvoBwYycTyD7YLOO4wj+uhHpeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-948196737-1334604550=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46882 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2DPT3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 15:29:11 -0400
In-Reply-To: <CAC83ZvKRMfP7xqmPLCwQWwTWxvoBwYycTyD7YLOO4wj+uhHpeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-948196737-1334604550=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Apr 2012, DebBarma, Tarun Kanti wrote:

> On Mon, Apr 16, 2012 at 10:20 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> >> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat=
-omap/include/plat/dmtimer.h
> >> index 9418f00..be2b8c4 100644
> >> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> >> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> >> @@ -259,7 +259,7 @@ struct omap_dm_timer {
> >> =A0 =A0 =A0 unsigned long phys_base;
> >> =A0 =A0 =A0 int id;
> >> =A0 =A0 =A0 int irq;
> >> - =A0 =A0 struct clk *iclk, *fclk;
> >> + =A0 =A0 struct clk *fclk;
> >>
> >> =A0 =A0 =A0 void __iomem =A0 =A0*io_base;
> >> =A0 =A0 =A0 void __iomem =A0 =A0*sys_stat; =A0 =A0 =A0/* TISTAT timer =
status */
> >
> > Am dropping this stray change, it seems unrelated to the rest of the
> > patch.
> Since the only usage of timer->iclk is removed from mach-omap2/timer.c
>  there is no
> point in keeping this field in struct omap_dm_timer {}.
> Unless you are suggesting that both the above should be separated into
> a separate patch?

Ah, I just missed the first removal line.  Never mind ...


- Paul
--155748971-948196737-1334604550=:29048--
