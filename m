From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
 non-dss2)
Date: Thu, 07 Jan 2010 13:11:13 +0200
Message-ID: <1262862673.2127.8.camel@tubuntu.research.nokia.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
	 <alpine.DEB.2.00.1001051030580.2083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64388 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0AGLKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 06:10:34 -0500
In-Reply-To: <alpine.DEB.2.00.1001051030580.2083@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: ext Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-01-05 at 18:32 +0100, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> On Tue, 15 Dec 2009, Tomi Valkeinen wrote:
> 
> > On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
> > > dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
> > > OMAP: OMAPFB: add omapdss device
> > > 
> > >     The upcoming new display subsystem driver is divided to two devices,
> > >     omapdss and omapfb, of which omapdss handles the actual hardware.
> > > 
> > >     This patch adds a dummy omapdss platform device for the current omapfb
> > >     driver, which is then used to get the clocks. This will make it possible
> > >     for the current and the new display drivers to co-exist.
> > > 
> > >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > >     Acked-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > breaks old omapfb.
> > 
> > I didn't look at this further, but I quickly tested with OMAP3 SDP
> > board, reverting the patch that makes SDP use DSS2, and it seems to work
> > fine with the old omapfb.
> > 
> > Perhaps you have more kernel debug options enabled, and then it
> > complains about missing release function. I'll look at it tomorrow.
> 
> This also affects omap_2430sdp_defconfig on 2430SDP:

I pushed patches fixing thisto master branch in my tree:
http://gitorious.org/linux-omap-dss2/linux

Can you try them out on 2320sdp? The commits are
3a2cbca3a3703ecd77c6fe633543ea0926b95564 and
c47f085ecf6d024c8850177694c702d814563580

 Tomi


