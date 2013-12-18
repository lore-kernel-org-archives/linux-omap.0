From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Date: Wed, 18 Dec 2013 09:33:15 -0800
Message-ID: <20131218173315.GE27438@atomide.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com>
 <20131216184157.GA26293@atomide.com>
 <52AFF31C.6010100@ti.com>
 <20131217153001.GN12324@atomide.com>
 <52B14AEE.8090807@ti.com>
 <52B17729.3040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30782 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752031Ab3LRRdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 12:33:19 -0500
Content-Disposition: inline
In-Reply-To: <52B17729.3040807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131218 02:22]:
> On 2013-12-18 09:12, Tomi Valkeinen wrote:
> 
> >> Well yeah let's keep those separate still as at least Russell needed
> >> some more time with the legacy booting. The point we can drop the
> >> legacy booting for omap3 may still need to wait a bit, maybe even
> >> until v3.15 to keep things working.
> > 
> > They can't be separate. Once I add DT support for a board, I have to
> > remove the legacy support for that board. This patch removes legacy
> > support for the boards that are converted in the series.
> > 
> > If I don't remove the legacy support, both DT and legacy side will be
> > ran, and both create the DSS devices...
> > 
> > But, it's true that this patch removes the whole file, as all the boards
> > currently there are converted. But if new boards are added to the DSS
> > quirks, then I can't remove the file. So I'll change this patch to only
> > remove the parts for the converted boards, not the whole file.
> > 
> > But but... If I understand right, the plan is to remove all omap3 board
> > files for the next merge window. I'm not totally familiar with the
> > quirks system, but how should this be handled:
> > 
> > omap3.dtsi will contain the SoC's DSS nodes. This means that DSS devices
> > are created via DT code. But if the display (i.e. panels) for a
> > particular omap3 board has not been converted to DT, we should still use
> > the legacy DSS initialization. But the DSS is already initialized via DT.
> > 
> > I guess I can set the status for all the DSS nodes to "disabled" in
> > omap3.dtsi, and that should prevent DT code from creating the DSS
> > devices. Then, each omap3-board.dts that has been converted to DSS DT,
> > can override those to "enabled".
> > 
> > That way the DT code should not create DSS devices by default, and the
> > quirks system would probably work fine.
> 
> I changed the DSS DT nodes to be disabled by default, and I think this
> works nicely. It's actually better this way in any case, as we can leave
> blocks like DSI out for boards that don't need it.
> 
> Also, I now remove the quirks only for the boards that are converted to
> DT, not the whole dss-common.c file. So I think we can now add new
> boards to dss-common.c, if and when there are ones that cannot be
> converted to use DSS DT yet.

OK

Tony
