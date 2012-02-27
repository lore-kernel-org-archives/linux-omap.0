From: Raghu <raghavendra.kh@gmail.com>
Subject: Re: OMAP PM constraint to disable OPP50
Date: Mon, 27 Feb 2012 11:32:41 -0600
Message-ID: <CAHu_vbqvXja0tGYyj4OgwvQEhfpgLq7BiK+f3mAGEExzbATksQ@mail.gmail.com>
References: <1329982132.1820.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54516 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2B0RdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 12:33:02 -0500
Received: by wibhm11 with SMTP id hm11so1435320wib.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 09:33:01 -0800 (PST)
In-Reply-To: <1329982132.1820.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On Thu, Feb 23, 2012 at 1:28 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Hi,
>
> This is an old issue, and I've mentioned earlier, but I think we should
> finally do something about this. Or perhaps this can already be done,
> but I don't know the solution.

I agree with you.
We need to address the L3 bandwidth requirement for DSS as needed by
high resolution panels.

>
> The problem is that various DSS clocks have max frequencies that depend
> on whether we are at OPP100 or OPP50 (e.g. table 10-4. DSS Clock
> Frequencies in OMAP4 TRM). Some of these clocks come from the PRCM (like
> DSS_CLK on OMAP4), but some are generated internally by DSS (like pixel
> clocks).
>
> While the clocks coming from PRCM could perhaps be handled automatically
> (from DSS's point of view) by the PM/clock framework so that OPP50 would
> be disabled if the clocks are over the OPP50-limit, I guess that's not
> quite correct. The max freq limitation is inside DSS HW, not in the PRCM
> side (well, I'm guessing so). And as we anyway need to handle some of
> the clock limits inside DSS, I guess it's simpler to handle them all in
> DSS.
>
> But the main question is, how should it be done? Afaik the dss driver
> cannot say "stay in OPP100" to the PM framework. I guess the closest
> thing is to set a constraint to memory throughput with an arbitrarily
> high value, thus forcing OPP100.
>
> But even if it's quite easy to come up with an arbitrary value that
> should be high enough for years to come, this approach feels rather
> hacky. Can it have side effects? May it cause overclocking, as the PM
> framework thinks we need as much bandwidth as possible? Does it cause
> higher power consumption because something in L3/Core/somewhere is kept
> in a high perf mode for the high mem throughput, even if we don't
> actually need high throughput?

I have been thinking to determine the L3 bandwidth requirement based
on the number of overlays/pipes enabled, width, height and color
format and use the PM API omap_pm_set_min_bus_tput()  to request the
required L3 bandwidth. This bandwidth request and release has to be
done for each frame.
I have been looking for right entry and exit functions in DSS drivers
to add this L3 bandwidth request/release.

Regards,
Ragha
