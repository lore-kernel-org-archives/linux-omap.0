From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Date: Wed, 18 Dec 2013 09:32:31 -0800
Message-ID: <20131218173230.GD27438@atomide.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com>
 <20131216184157.GA26293@atomide.com>
 <52AFF31C.6010100@ti.com>
 <20131217153001.GN12324@atomide.com>
 <52B14AEE.8090807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29272 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753195Ab3LRRcf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 12:32:35 -0500
Content-Disposition: inline
In-Reply-To: <52B14AEE.8090807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131217 23:14]:
> On 2013-12-17 17:30, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 22:47]:
> >> On 2013-12-16 20:41, Tony Lindgren wrote:
> >>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
> >>>> As a temporary solution to enable DSS for selected boards when booting
> >>>> with DT, a hack was added to board-generic.c in
> >>>> 63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
> >>>> DSS for panda & sdp boards).
> >>>>
> >>>> We're now adding proper DT support, so the hack can be removed.
> >>>
> >>> I guess this patch should be merged later on after we have the DT support
> >>> working?
> >>
> >> I'll move this patch also to the end of the series.
> >>
> >> "Merged later" sounds like you mean this could be merged in a separate
> >> series. I think this and the other removal can be in this series, they
> >> just need to be at the end.
> > 
> > Well yeah let's keep those separate still as at least Russell needed
> > some more time with the legacy booting. The point we can drop the
> > legacy booting for omap3 may still need to wait a bit, maybe even
> > until v3.15 to keep things working.
> 
> They can't be separate. Once I add DT support for a board, I have to
> remove the legacy support for that board. This patch removes legacy
> support for the boards that are converted in the series.

Oh OK yeah makes sense. I was worried about the legacy board-*.c files..
 
> If I don't remove the legacy support, both DT and legacy side will be
> ran, and both create the DSS devices...
> 
> But, it's true that this patch removes the whole file, as all the boards
> currently there are converted. But if new boards are added to the DSS
> quirks, then I can't remove the file. So I'll change this patch to only
> remove the parts for the converted boards, not the whole file.

OK
 
> But but... If I understand right, the plan is to remove all omap3 board
> files for the next merge window. I'm not totally familiar with the
> quirks system, but how should this be handled:
> 
> omap3.dtsi will contain the SoC's DSS nodes. This means that DSS devices
> are created via DT code. But if the display (i.e. panels) for a
> particular omap3 board has not been converted to DT, we should still use
> the legacy DSS initialization. But the DSS is already initialized via DT.
> 
> I guess I can set the status for all the DSS nodes to "disabled" in
> omap3.dtsi, and that should prevent DT code from creating the DSS
> devices. Then, each omap3-board.dts that has been converted to DSS DT,
> can override those to "enabled".
> 
> That way the DT code should not create DSS devices by default, and the
> quirks system would probably work fine.

No need for DSS related quirks for the DT boot case. I was concerned about
the legacy board-*.c case.

Tony
