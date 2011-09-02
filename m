From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Fri, 02 Sep 2011 10:55:43 +0300
Message-ID: <1314950143.3374.30.camel@deskari>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
	 <1314701495-11247-11-git-send-email-archit@ti.com>
	 <1314882869.2169.22.camel@lappyti>  <4E606675.5010403@ti.com>
	 <1314941566.1907.16.camel@deskari>  <4E6073FC.3070107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:32833 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932650Ab1IBJSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 05:18:41 -0400
Received: by bkbzs8 with SMTP id zs8so3273987bkb.40
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 02:18:39 -0700 (PDT)
In-Reply-To: <4E6073FC.3070107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-09-02 at 11:43 +0530, Archit Taneja wrote:
> > Sending a null packet to start the DDR clk is rather OMAP specific
> > internal thing, so I don't want to require the panel driver to need
> to
> > know that it must send a null packet to start the clock. So if the
> ddr
> > clk is not started automatically, I think we should have a function
> to
> > do that (dsi_start_ddr_clk or whatever), which will then send the
> null
> > packet (and perhaps return an error if DDR_CLK_ALWAYS_ON is not set,
> > dunno...).
> 
> Okay, If we can confirm that a panel asks for DDR_CLK_ALWAYS_ON
> mainly 
> because it doesn't have its own fclk, then the dsi driver surely
> needs 
> to start the DDR clock by sending a NULL packet.
> 
> If this is to be done, one thing that has to be thought of is:
> 
> - We need one of the requested VC's to be in HS mode for this. Do we 
> enable HS for a VC in the dsi driver itself? Currently, its the job
> of 
> the panel driver to enable HSmode for a VC. Is this a clean approach? 

I have to say I don't have any idea what would be the best approach...

What comes to my mind is that the DSI driver could automatically send
the null packet, when:

a) ddr_clk_always_on is set
b) a channel is changed to HS and enabled (I guess it needs to be
enabled also, does it?)

Well, we do seem to enable all VCs at init phase (which, thinking about
it, sounds a bit odd), so in practice we would just need to handle the
omapdss_dsi_vc_enable_hs() case.

 Tomi


