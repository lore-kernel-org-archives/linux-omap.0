From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP DSS HWMOD fixes
Date: Mon, 08 Aug 2011 15:23:02 +0300
Message-ID: <1312806182.1747.7.camel@lappyti>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
	 <4E3FCBDC.1080208@ti.com> <1312805027.1747.4.camel@lappyti>
	 <4E3FD4E1.9020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59451 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752502Ab1HHMXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 08:23:10 -0400
Received: by mail-ey0-f169.google.com with SMTP id 22so2859315eye.28
        for <linux-omap@vger.kernel.org>; Mon, 08 Aug 2011 05:23:07 -0700 (PDT)
In-Reply-To: <4E3FD4E1.9020702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Mon, 2011-08-08 at 17:51 +0530, Archit Taneja wrote:
> Hi,
> 
> On Monday 08 August 2011 05:33 PM, Valkeinen, Tomi wrote:
> > On Mon, 2011-08-08 at 17:13 +0530, Archit Taneja wrote:
> >> Hi,
> >>
> >> On Monday 08 August 2011 02:45 PM, Valkeinen, Tomi wrote:
> >>> Second try with the DSS HWMODs
> >>>
> >>> This set fixes the DSS clocks in HWMOD data, and implements a new reset
> >>> mechanism for dss_core.
> >>>
> >>> The new dss_reset function doesn't actually do a reset, it just enables all DSS
> >>> clocks and waits for the reset to complete. This should be better approach than
> >>> actually doing a reset, because:
> >>>
> >>> OMAP4 - dss_core HW doesn't contain a SW reset bit so doing a reset is
> >>> impossible. But after power-on we need to enable all DSS clocks and wait for
> >>> the power-on reset to complete.
> >>>
> >>> OMAP2/3 - dss_core does have a SW reset bit, but resetting dss_core also resets
> >>> all the other DSS modules. This means that the other modules could be left
> >>> uninitialized, as the hwmod code handles all modules independently, and in this
> >>> case initializes only dss_core's registers. Thus dss_core's reset shouldn't be
> >>> used, and we should only verify that the power-on reset has completed.
> >>
> >> If the bootloader enables DSS, we need to do a reset so that DSS2 driver
> >> can start with DSS HW in a clean state. With this patch set, how do we
> >> take care of such a scenario?
> >
> > We don't. That should be done in a future patch.
> >
> > I think we should extend this reset function, and disable the LCD
> > outputs and reset the clock switches there.
> >
> > I didn't want to do that yet as I wanted to fix the current problem with
> > the reset first and I don't have an environment where to test it. I hope
> > you can help here =).
> 
> Yes, we can extend over this. But we would still access DISPC registers 
> in the dss_core's custom reset function. Wouldn't this break the "HWMOD 
> model where every DSS module is independent"?

Yes, it won't be as neat as I'd like to, but it shouldn't break
functionally anything.

I thought of adding a new reset function for dss_dispc, but I don't
think that would work, as we need to reset the clock switches (in
dss_core). And if we'd reset the clock switches while dispc output is
enabled, things could again break.

So only solution I can think of is to have dss_core do all those things.
Well, another solution would be to skip the DSS resets totally if DSS
output is enabled. I'm not sure if that's a good solution, though.

 Tomi


