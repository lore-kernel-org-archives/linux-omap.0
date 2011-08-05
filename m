From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAP4: DSS2: VIDEO3 pipeline support
Date: Fri, 05 Aug 2011 12:26:36 +0300
Message-ID: <1312536396.1907.37.camel@deskari>
References: <1312530172-24095-1-git-send-email-archit@ti.com>
	 <1312530172-24095-6-git-send-email-archit@ti.com>
	 <CAB2ybb_fDM8bDr1CsFUHRhE9fNoSKvOoWTktQGzh+VV=efEMZw@mail.gmail.com>
	 <CAB2ybb_5saT0_DCcL5iTKaNfJfV32iQvV_mhv_uC+tt-J4CNgA@mail.gmail.com>
	 <4E3BB603.7010908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:43150 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105Ab1HEJ0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 05:26:45 -0400
Received: by mail-fx0-f50.google.com with SMTP id 2so2413480fxh.37
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 02:26:42 -0700 (PDT)
In-Reply-To: <4E3BB603.7010908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-08-05 at 14:51 +0530, Archit Taneja wrote:
> Hi,
> 
> On Friday 05 August 2011 02:13 PM, Semwal, Sumit wrote:
> >> On Fri, Aug 5, 2011 at 8:42 AM, Archit Taneja<archit@ti.com>  wrote:
> >>>
> >>> Add support for VIDEO3 pipeline on OMAP4:
> >>> - Add VIDEO3 pipeline information in dss_features and omapdss.h
> >>> - Add VIDEO3 pipeline register coefficients in dispc.h
> >>> - Create a new overlay structure corresponding to VIDEO3.
> >>>
> >>> Signed-off-by: Archit Taneja<archit@ti.com>
> >>> ---
> > <snip>
> >>> -       u32     fifo_size[3];
> >>> +       u32     fifo_size[MAX_DSS_OVERLAYS];
> >>
> > Do you think it makes some sense in splitting the 'generalisation'
> > like this that you've done in the patch from the xxx_VIDEO3 changes?
> 
> Yes, I could make a small patch which replaces "3" with 
> MAX_DSS_OVERLAYS, and the patch which introduces VIDEO3 pipe will 
> increase the macro value from 3 to 4.

While Sumit is right, I don't think that's worth the effort if it's just
about this single line.

I think this patch set looks fine. At least the register dump works just
the way I like it. I didn't test the vid3 yet, though.

 Tomi


