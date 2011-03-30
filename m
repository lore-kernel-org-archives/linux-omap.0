From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Wed, 30 Mar 2011 14:03:47 +0300
Message-ID: <1301483027.4045.16.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38143 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932086Ab1C3LDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 07:03:51 -0400
Received: by gxk22 with SMTP id 22so561338gxk.2
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 04:03:50 -0700 (PDT)
In-Reply-To: <4D92F899.7010606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 2011-03-30 at 11:32 +0200, Cousson, Benoit wrote:
> Hi Tomi,
> 
> On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
> > Hi Benoit, Paul,
> >
> > I've been discussing with Sumit and Archit to understand how the DSS
> > clocks are set up on OMAP4. I think I now have some idea how things
> > work, but I'm still at loss why things are the way they are.
> >
> > So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
> > clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
> > and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
> > controllable, but it is affected by MODULEMODE bit.
> >
> > Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
> > and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
> > the TRM's DSS_FCLK.
> >
> > Was that correct?
> 
> Yes. For the moment, but this is not the final state.
> 
> > If so, from DSS driver's perspective, the dss_fck sounds very much like
> > an interface clock (it's always needed when DSS is used) and dss_dss_clk
> > sounds very much like functional clock (it's always needed, except if
> > DSI PLL is used for DSS functional clock).
> >
> > If "dss_fck" would control DSS_FCLK and "dss_ick" would control
> > MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
> > and we wouldn't need any omap4 spesific trickery in the DSS driver.
> > ("dss_dss_clk" wouldn't be needed).
> 
> You cannot play with iclk, because this clock is supposed to be handled 
> automatically by the HW. This was the case on OMAP2 & 3 as well BTW.

Right.

But now we have 1) dss_fck, which isn't the DSS_FCLK in TRM, and in fact
not fck at all, or even clock at all 2) dss_dss_clk, a new clock whose
name doesn't match to anything in TRM, and is in fact the DSS_FCLK.

So they both sound like they are confusingly named.

If we had dss_fck matching to DSS_FCLK and dss_ick for MODULEMODE, they
would, in my opinion, be much more understandable and in many ways
relate to the way things are in the HW. Additionally this would match
the way clocks are on OMAP2/3 and things would just work.

So while I understand that neither the current way and my suggestion
exactly match the HW, and also that things are not ready yet and the
clocks will change, I don't understand why such a strange method to name
the clocks was used, when there's a simpler and backward compatible way.

And if this current way to handle OMAP4 DSS clocks is for some reason
better and can't be changed, could the OMAP2/3 clocks also be changed to
keep things consistent between OMAPs? Because the inconsistency between
platforms is the biggest problem for me.

 Tomi


