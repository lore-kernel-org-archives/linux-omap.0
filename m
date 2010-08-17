From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2 patch series
Date: Tue, 17 Aug 2010 13:52:26 +0300
Message-ID: <1282042346.2348.35.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
	 <1280995782.3436.205.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:51369 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab0HQKwc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:52:32 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-08-10 at 11:33 +0200, ext Taneja, Archit wrote:
> [Archit] I have collected some information about what these revision
> numbers mean from the TI folks. The following is what I have gathered:
> 
> -For each broad version of OMAP, like OMAP3430, OMAP3630, OMAP4430 and so on,
> there is an independent revision list. These are changed/incremented when
> the corresponding IP blocks are modified. The numbers which we see are probably
> the ones which were chosen to put into the silicon.
> 
> So, it is possible that the revision numbers of ES_1 of OMAP3430 is exactly the
> same as the ES_1 of OMAP3630 even if the IP blocks have changed. This is what is
> seen in the prints of the revision of 3430 and 3630 I sent in the previous mail.
> 
> These revision numbers are hence useful only within the revisions of a particular
> OMAP. It looks like that there is no single revision chain since OMAP2.
> 
> -After discussions with more TI DSS folks, it seems that some changes that we may
> need to make in DSS software may not be dependent on the DSS hardware at all. For example,
> the patch "OMAP3630:DSS2: Updating MAX divider value" was introduced because of a change
> in PRCM.
> 
> So it seems that we will need to have omap2, omap3 and omap4 checks , best we can
> do is prevent them from scattering around, i.e have them at a single place during
> initialization.

Ok. Well, good that it's clear now =).

> How do you think we can clean things up?

If I remember right, there's some kind of feature framework being worked
on (or ready?), but I haven't looked at that at all. That may or may not
suit our needs.

But perhaps we could just have a separate dss_features.c file, which
would contain a bunch of functions that can be used to ask whether a
certain feature is supported, and also to ask certain values (max
dividers or similar).

 Tomi


