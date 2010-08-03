From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2 patch series
Date: Tue, 03 Aug 2010 11:43:43 +0300
Message-ID: <1280825023.3436.111.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39463 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0HCIoK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 04:44:10 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-08-02 at 14:05 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> > On Tue, 2010-07-27 at 10:27 +0200, ext Taneja, Archit wrote:
> > > Hi,
> > > 
> > > We had pushed three patch series while you were out. We 
> > received some 
> > > good comments on them. We wanted to know if you can point out more 
> > > fixes and susuggestions before we rework them.
> > > 
> > > https://patchwork.kernel.org/patch/111901/
> > > 
> > > https://patchwork.kernel.org/patch/112648/
> > > 
> > > https://patchwork.kernel.org/patch/112653/
> > 
> > Do you have updated patches for these? It would be easier to 
> > review new ones than the old ones.
> > 
> >  Tomi
> 
> The comments on the existing patches have been mostly related
> to minimizing the number of patches in each series, moving some
> #defines to header files and one or two typos.
> 
> I haven't reworked these patches yet, I wanted to know if you
> could review the changes you had suggested on the v1 of the series
> below:

I think the register handling looks much better now. Although defines
like this:

+#define DISPC_DEFAULT_COLOR(ch)	DISPC_REG(ch == OMAP_DSS_CHANNEL_LCD \
+				? (0x004C) : (ch == OMAP_DSS_CHANNEL_DIGIT ? \
+				(0x0050) : (0x03AC)))

makes me wonder if a separate lookup table would be cleaner. But perhaps
it's not too bad yet.

Also, we should think how to reduce if (cpu_is_omap44xx()) lines. There
should be some kind of DSS capability list somewhere, which would tell
the features available. I haven't thought this more, but it'd be very
nice if we could use the DSS HW version number to decide what features
there are.

However, TI answered that information about DSS HW version numbers is
not available, and thus cannot be used =(. Perhaps you could try to dig
out some information from inside TI?

And, as others have commented, consider how to split the patches. The
most important rule is that every stage in the patch set has to compile.

One thing that I personally think makes patch sets clearer, is to divide
a new functionality into two parts: 1) modify the old code, without
adding new functionality, so that the new functionality is easier to add
2) add the new functionality.

As an example, if we look at the new DISPC registers patch:

There could first be a patch that introduces DISPC_XXX(channel) style
registers (even if there's only one channel available) and modifies the
functions accordingly. 

The second patch would introduce OMAP4 registers and whatever new
functionality these registers require.

This way it would be easy to study and test the first patch, as it
shouldn't introduce any new functionality, but just "shuffles the code
around".

And it would be easy to study the second patch, as the needed base
functionality is already there, and there's lot less new stuff added.

 Tomi


