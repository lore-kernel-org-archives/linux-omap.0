From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 13 Jun 2012 23:35:25 -0700
Message-ID: <20120614063524.GB12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com>
 <20120613120717.GP12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E43@DBDE01.ent.ti.com>
 <20120613134032.GW12766@atomide.com>
 <20120613134408.GY12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998F2F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59913 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2FNGf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 02:35:27 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998F2F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 06:56]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 19:20:35, Mohammed, Afzal wrote:
> > Hi Tony,
> > 
> > On Wed, Jun 13, 2012 at 19:14:08, Tony Lindgren wrote:
> > 
> > > Actually why do you even need to store the revision? You can
> > > just read it from the hardware as needed.
> > 
> > Earlier for wr_access & wr_data_mux_bus, we were checking,
> > cpu_is_34xx, but I feel it should instead be based on
> > IP revision as it is the IP revision that decides the
> > availability of those register bits.
> 
> Or you meant, even there read revision register ?

Yeah that should be fine as this really should only happen
during init and whatever revision specific features can
be initialized for GPMC.

Tony
