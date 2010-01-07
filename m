From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
 non-dss2)
Date: Thu, 07 Jan 2010 13:46:23 +0200
Message-ID: <1262864783.2127.18.camel@tubuntu.research.nokia.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
	 <48239d390912150801y70da9d46k637c01d8da3a5595@mail.gmail.com>
	 <1260962480.15771.1.camel@tubuntu.research.nokia.com>
	 <48239d390912170651g1dab3c37ycbbbd2df1f722f3b@mail.gmail.com>
	 <1262862298.2127.6.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17920 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab0AGLpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 06:45:45 -0500
In-Reply-To: <1262862298.2127.6.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergey Lapin <slapinid@gmail.com>, ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-01-07 at 12:05 +0100, Tomi Valkeinen wrote:
> On Thu, 2009-12-17 at 15:51 +0100, ext Sergey Lapin wrote:
> > On Wed, Dec 16, 2009 at 2:21 PM, Tomi Valkeinen
> > <tomi.valkeinen@nokia.com> wrote:
> > > Hi,
> > >
> > > On Tue, 2009-12-15 at 17:01 +0100, ext Sergey Lapin wrote:
> > >> On Tue, Dec 15, 2009 at 6:22 PM, Tomi Valkeinen
> > >> <tomi.valkeinen@nokia.com> wrote:
> > >> > Hi,
> > >> >
> > >> > On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
> > >> >> dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
> > >> >> OMAP: OMAPFB: add omapdss device
> > >> >>
> > >> >>     The upcoming new display subsystem driver is divided to two devices,
> > >> >>     omapdss and omapfb, of which omapdss handles the actual hardware.
> > >> >>
> > >> >>     This patch adds a dummy omapdss platform device for the current omapfb
> > >> >>     driver, which is then used to get the clocks. This will make it possible
> > >> >>     for the current and the new display drivers to co-exist.
> > >> >>
> > >> >>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > >> >>     Acked-by: Tony Lindgren <tony@atomide.com>
> > >> >>
> > >> >> breaks old omapfb.
> > >> >
> > >> > I didn't look at this further, but I quickly tested with OMAP3 SDP
> > >> > board, reverting the patch that makes SDP use DSS2, and it seems to work
> > >> > fine with the old omapfb.
> > >
> > > rfbi.c was still using omapfb device to get the clocks. Can you try this
> > > patch?
> > >
> > >
> > > >From 33b78006fb0387e21d5f780338d821621ecad929 Mon Sep 17 00:00:00 2001
> > > From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > > Date: Wed, 16 Dec 2009 13:18:07 +0200
> > > Subject: [PATCH] OMAP: OMAPFB: fix clk_get for RFBI
> > >
> > > omapfb platform device was still used to get clocks inside rfbi.c
> > If you add #include <linux/platform_device.h> to this patch,
> > then problem is fixed.
> 
> Hmm, where do you need to add that include? n770 compiles ok for me.
> 
> I pushed this patch and another patch fixing the warning to master
> branch in my tree:
> http://gitorious.org/linux-omap-dss2/linux
> 
> Can you try them out? The commits are
> 3a2cbca3a3703ecd77c6fe633543ea0926b95564 and
> c47f085ecf6d024c8850177694c702d814563580

Sorry, I was too hasty. The release function should return void, not
int.

The new patches are
3a2cbca3a3703ecd77c6fe633543ea0926b95564 and
ed18458714274525545349a2c35cf32f4a17f166

 Tomi



