From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Tue, 12 Apr 2011 10:17:20 +0300
Message-ID: <1302592640.2224.31.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
	 <1302241893.2102.21.camel@deskari>
	 <alpine.DEB.2.00.1104080753070.22291@utopia.booyaka.com>
	 <1302512700.2198.53.camel@deskari>
	 <alpine.DEB.2.00.1104111211010.2837@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44254 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754712Ab1DLHRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 03:17:25 -0400
Received: by mail-wy0-f177.google.com with SMTP id 28so8151646wyb.22
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 00:17:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104111211010.2837@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2011-04-11 at 12:20 -0600, Paul Walmsley wrote:
> Hi
> 
> On Mon, 11 Apr 2011, Tomi Valkeinen wrote:

> > However, I think there is one difference between the clock used just to
> > enable the DSS registers, and the one used to output pixels: we need to
> > be able to adjust the rate of the clock. Thus we need to have a common
> > (omap2/3/4) clock name for it to be able to clk_get() it.
> >
> > Should that clock name be just the "main" clock provided automatically,
> > or something else?
> 
> Are you referring here to the system DPLL and its output dividers, or are 
> you referring to the DSS module's internal dividers?

The system DPLL and its divider. If we are using the dss_dss_clk as
fclk, we need to adjust it depending on the required pixel clock and use
cases (e.g. some scaling factors may need higher fclk).

 Tomi


