From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 07 Jun 2011 14:51:44 +0300
Message-ID: <1307447504.1858.37.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>
	 <4DECCE90.6070201@ti.com> <1307365290.1910.39.camel@deskari>
	 <4DECD2D7.6030207@ti.com> <1307366474.1910.44.camel@deskari>
	 <4DECDA3A.7080808@ti.com> <1307368525.1910.50.camel@deskari>
	 <4DECF215.5020505@ti.com> <1307429547.1858.10.camel@deskari>
	 <4DEE0D7E.6090309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47336 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1FGLvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 07:51:48 -0400
In-Reply-To: <4DEE0D7E.6090309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On Tue, 2011-06-07 at 13:37 +0200, Cousson, Benoit wrote:
> On 6/7/2011 8:52 AM, Valkeinen, Tomi wrote:
> > On Mon, 2011-06-06 at 17:28 +0200, Cousson, Benoit wrote:
> >
> >> Before doing that, could you maybe just try something to make OMAP4
> >> looks a little bit more like OMAP3?
> >>
> >> dss_fck ->  ick
> >> dss_dss_fck ->  main_clk
> >>
> >> That should ensure that both modulemode and the PRCM fclk will be
> >> managed by pm_runtime.
> >
> > I made the changes as you suggested, and while I haven't made the
> > changes to omapdss yet to see if I can remove the dispc_runtime_get/put
> > style function, I can boot up and start the dss.
> >
> > However, after booting up but before enabling the dss driver, I can see
> > that the clock counts are:
> >
> > dss_tv_clk 0
> > dss_sys_clk 0
> > dss_fck 7
> > dss_dss_clk 0
> > dss_48mhz_clk 0
> >
> > So the modulemode is set for all dss hwmods? Isn't this exactly how it's
> > _not_ meant to be, as modulemode should be set only after enabling the
> > fck?
> 
> The issue is that there is only one modulemode for the whole DSS.
> Potentially only the dss_hwmod should have it. But then you have to 
> ensure that this device is enabled before any other DSS devices.

Does that change anything? Isn't the above (modulemode enabled before
opt clock) still true, even if it was enabled only once for the dss_core
hwmod?

And for PM, it doesn't matter if the dss_fck is enabled once or seven
times, I presume a use count of one will still prevent RET or OFF?

> If you cannot do that at your level, we will have to set a hwmod 
> dependency between DSS modules and the main DSS subsystem.
> For the moment we do not have such HW dependencies.

I can do this in the driver, and in fact I already do. The dss_core
hwmod is enabled by all the other hwmods before they do anything.

My reasoning for this dependency is that the dss_core contains for
example the clock mux registers, and other misc registers used by most
other dss modules. But I'm not sure if this dependency should be in the
hwmod level or not.

 Tomi


