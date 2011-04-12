From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Tue, 12 Apr 2011 10:29:51 +0300
Message-ID: <1302593391.2224.43.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
	 <1302241893.2102.21.camel@deskari>
	 <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com>
	 <1302512187.2198.44.camel@deskari>
	 <alpine.DEB.2.00.1104110946000.22291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55021 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756732Ab1DLH34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 03:29:56 -0400
Received: by mail-ww0-f43.google.com with SMTP id 17so7230788wwb.0
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 00:29:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104110946000.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2011-04-11 at 10:05 -0600, Paul Walmsley wrote:
> Hi
> 
> On Mon, 11 Apr 2011, Tomi Valkeinen wrote:
> 
> > On Fri, 2011-04-08 at 10:28 -0600, Paul Walmsley wrote:
> > > On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
> > > 
> > > > > Also, I hope you and the other DSS hackers can finish the PM runtime
> > > > > conversion of the DSS driver soon.  Ideally before any new DSS
> > > > > features are added.  We really need to be able to separate the OMAP
> > > > > integration details from the drivers, and right now, hwmod and PM
> > > > > runtime are the best way we have to do that.
> > > > 
> > > > I also started to look at the PM runtime, but it doesn't fix the issue
> > > > with the inconsistent clock name I described above.
> > > 
> > > After the hwmod/PM runtime conversion, I don't think any of the clock 
> > > aliases currently in clock*_data.c should be used by the DSS driver (or by 
> > > anything else on the system, for that matter).  That's because the 
> > > omap_device code should set up the "main" alias for the DSS main 
> > 
> > When should "main" clock be used by the driver? Or never, and pm_runtime
> > handles that?
> 
> If the DSS needs to change the parent or the clock rate of the main clock, 
> then it will need to clk_get(dev, "main") and use the clock API.  My only 
> point here was that the "main" alias should be automatically added by the 
> omap_device code, not via the clock aliases in clock*_data.c.

Ok.

> > How about OMAP3? It also has an optional functional clock, but that
> > doesn't seem to be set in dss_opt_clocks in omap_hwmod_3xxx_data.c.
> > Should it be there?
> 
> Probably so.
> 
> > It seems dss1_alwon_fclk is currently the main clock for OMAP3 dss
> > hwmods. Does that mean it can never be turned off if DSS is in use?
> 
> If the DSS driver were using PM runtime, then yes, that would be true.

Ok. Then there's also room for improvement, as the dss1_alwon_fclk is an
optional clock on OMAP3.

> > Ok. Then we need omap_hwmod_opt_clk for at least for VENC and HDMI, I
> > believe.
> 
> In terms of the VENC, I'd agree with that -- based on OMAP4 Public TRM Rev 
> O Figure 10-177 "Video Encoder Overview," it looks like VENC uses 
> DSS_TV_FCLK.

On OMAP3 DSS_96M_FCLK goes to VENC's video DACs. I don't quite
understand how it goes in OMAP4, the clock tree figure shows something
going into VDAC, but it's unclear what. Well, anyway, the point was not
to dig out the clocks now, but just to point out that some extra clocks
are needed =).

> In terms of the HDMI IP block, based on OMAP4 Public TRM Rev O Figure 
> 10-159 "HDMI Overview," it looks like sys_clk should be one of the 
> optional clocks for HDMI?  Hard to tell from that diagram.

Yes, I think sys_clk is the input clock for the HDMI PLL. The output
from the PLL can then be used for DISPC fckl.

I believe HDMI_PHY_48M_FCLK ("dss_48mhz_clk") is also needed.

 Tomi


