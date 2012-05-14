From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
Date: Mon, 14 May 2012 15:55:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205141553280.1640@xanadu.home>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
 <20120504175942.5ceb8e91@skate> <4FB11F63.2010108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_5KMK3WOE+fSdDgPE0CUKuQ)"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:64875 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2ENTzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 15:55:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M41009373BSI8A0@VL-VM-MR006.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 14 May 2012 15:55:05 -0400 (EDT)
In-reply-to: <4FB11F63.2010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_5KMK3WOE+fSdDgPE0CUKuQ)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Mon, 14 May 2012, Cousson, Benoit wrote:

> Salut Thomas,
> 
> Sorry for the delay.
> 
> On 5/4/2012 5:59 PM, Thomas Petazzoni wrote:
> > Hello Benoit,
> > 
> > Le Fri, 23 Sep 2011 22:23:09 +0200,
> > Benoit Cousson<b-cousson@ti.com>  a écrit :
> > 
> > > Add SoC specific map_io function to be used by the generic DT
> > > board file. This is an intermediate step before having some
> > > generic DT aware map_io function.
> > > 
> > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > Cc: Tony Lindgren<tony@atomide.com>
> > 
> > Do you know if some progress has been made on having a generic DT aware
> > map_io function, or is the per-SoC ->map_io() function still the
> > recommended way of handling SoC having different requirements of static
> > mappings at boot time?
> 
> Mmm, Maybe I'm wrong, but I'm not sure people are really pushing to store that
> inside DT. But to be honest, I don't really know :-)

In general, static vs dynamic IO mappings are just some Linux 
implementation details.  This distinction does not belong in DT.


Nicolas

--Boundary_(ID_5KMK3WOE+fSdDgPE0CUKuQ)--
