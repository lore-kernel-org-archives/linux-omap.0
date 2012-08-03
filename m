From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: convert to
 module_platform_driver"
Date: Fri, 3 Aug 2012 15:46:56 +0300
Message-ID: <20120803124656.GB731@harshnoise.musicnaut.iki.fi>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
 <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
 <1343981127.2744.28.camel@deskari>
 <20120803094553.GA731@harshnoise.musicnaut.iki.fi>
 <20120803095836.GE6073@arwen.pp.htv.fi>
 <501BBB18.5090201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:57033 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2HCMrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 08:47:01 -0400
Content-Disposition: inline
In-Reply-To: <501BBB18.5090201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: balbi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

Hi,

On Fri, Aug 03, 2012 at 05:20:48PM +0530, Shubhrajyoti wrote:
> On Friday 03 August 2012 03:28 PM, Felipe Balbi wrote:
> >> [    1.496124] spi spi1.0: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
> >> > [    1.503265] omap2_mcspi omap2_mcspi.1: registered child spi1.0
> >> > 
> >> > If I modify the board file so that child spi1.0 is registered before
> >> > spi1.2, then it starts to work properly:
> > that sounds quite odd... Shubhro, have you seen this before on any of
> > our platforms ?
> >
> I havent seen this behaviour may be I didn't have this configuration.
> Will try to see if I have any way of recreating and testing the multi cs
> on one of our boards.
> 
> BTW I didnt understand why does that matter at all the cs order.
> 
> Aaro,
> I am missing what is making the order matter.
> What is it that I am missing?

With multiple CS you need to configure all CHCONFx regs before any
transfers work. This has been seen earlier with context save and restore
for PM. See e.g. commit 89c05372d08f3982eeb94d1ea22a60a5eaa8cd6d.

A.
