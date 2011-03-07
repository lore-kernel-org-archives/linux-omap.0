From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Problem with DSS clocks & accessing registers
Date: Mon, 7 Mar 2011 19:35:13 +0530
Message-ID: <90dc32aa0eb6d68d2a56424de664653d@mail.gmail.com>
References: <1299486149.2281.77.camel@deskari> <4D74E2D5.2000705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54906 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753127Ab1CGOFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 09:05:17 -0500
Received: by mail-qy0-f176.google.com with SMTP id 30so3940715qyk.0
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 06:05:16 -0800 (PST)
In-Reply-To: <4D74E2D5.2000705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>, Sumit Semwal <sumit.semwal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Archit Taneja <archit@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> Sent: Monday, March 07, 2011 7:21 PM
> To: Valkeinen, Tomi; Nayak, Rajendra
> Cc: Paul Walmsley; Hilman, Kevin; linux-omap; Taneja, Archit;
> Semwal, Sumit
> Subject: Re: Problem with DSS clocks & accessing registers
>
> + Rajendra
>
> Hi Tomi,
>
> On 3/7/2011 9:22 AM, Valkeinen, Tomi wrote:
> > Hi Kevin, Paul,
> >
> > We currently have a small problem with OMAP4 DSS. When we enable
> the DSS
> > clocks, it seems that the DSS registers are not always accessible
> right
> > after the clock enable.
>
> What clocks are you talking about? As you know, the DSS has a bunch
> of functional clocks available depending of the use case.
>
> > I understood that on OMAP4 the clock framework doesn't guarantee
> that
> > the registers are accessible after enabling clocks, and pm_runtime
> will handle this. Is this correct?
>

This seems to the question about a so called optional clock (DSS_CLK)
which really not an optional clock :)

This clock needs to be enabled and disabled along with interface and
functional clock for the registers access to work.

If you look internals of the clock routing in DSS, Figure 10-4
this clock is not really optional. You can call it optional because
there can be a option to use PLL clock instead of this one. But the
fact is either DSS_CLK or the PLL clock has to be running for the
IP accesses to work.

Sumit,
Please add more points about our discussion on this one.

Regards,
Santosh
