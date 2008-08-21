From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 19:08:40 +0300 (EEST)
Message-ID: <20080821.190840.165922192.Hiroshi.DOYU@nokia.com>
References: <20080819062422.GD17276@atomide.com>
	<20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E12EC5BDC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29193 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbYHUQJN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 12:09:13 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E12EC5BDC@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: tony@atomide.com, felipe.contreras@gmail.com, soni.trilok@gmail.com, vpasam@ti.com, linux-omap@vger.kernel.org, r-woodruff2@ti.com, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 10:37:12 -0500

> Hi Doyu-san,
> 
> > I think that this virtual clock may allow any arbitrary combination of
> > clocks and it may be possible to have multiple hierarchy of virtual
> > clocks like:
> > 
> >    dsp_clocks
> >    |
> >    |-- peripheral_clocks
> >    |     |
> >    |     |-- gpt5
> >    |     |    |- gpt5_ick
> >    |     |    `- gpt5_fck
> >    |
> >    |-- ....
> >    ..
> > 
> > Any comments would be appreciated.
> 
> 
> The feature looks good, but I think we cannot use this in DSP Bridge
> for following reasons.
> 
> This implementation is under the assumption that we will either
> enable or disable all the registered Bridge Peripherals clocks,
> which is not the case in reality.
> 
> In Bridge, we cannot make the assumption that all the registered
> clocks will be enabled. Bridge cannot use the vclk_enable function
> because this will enable all the registered clocks, which is not
> accepted. The clocks should be enabled only based on the request
> from DSP...it is use case driven.

Agreed, thinking about the above use case(operation).

	Hiroshi DOYU

