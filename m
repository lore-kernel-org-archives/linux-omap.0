From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Fri, 11 May 2012 15:50:51 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98B337@DBDE01.ent.ti.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com> <20120509081047.GC17333@parrot.com>
 <20120509153141.GI5088@atomide.com>
 <1336655257.2625.8.camel@sauron.fi.intel.com>
 <20120510151725.GA11107@parrot.com> <1336665138.2243.1.camel@brekeke>
 <20120510174527.GA11275@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab2EKPvD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 11:51:03 -0400
In-Reply-To: <20120510174527.GA11275@parrot.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>, Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Ivan,

On Thu, May 10, 2012 at 23:15:27, Ivan Djelic wrote:
> > > So, when Afzal's patches are pushed, I'll submit a new, single MTD patch.
> > 
> > But this is not going to happen this merge window as I understood, may
> > be not even the next one. We need to make UBIFS happy sooner than that,
> > I think. So may be we go forward with your original patch?
> 
> I'm OK with this too, as the patches are ready and tested.
> The MTD patch is [2], it depends on [1] which has been pushed, then dropped by Tony.
> Do you need me to repost [2] ?
> 
> Tony, sorry to backpedal on this: would you re-push patch [1], if indeed Afzal's patches
> are not going to be merged soon ? In the meantime, I can prepare a patch on top of Afzal's to
> have a smooth transition w.r.t BCH support. What do you think ?

A new series [A-D] has been sent for handling GPMC NAND registers by NAND driver
itself. This is being targeted for 3.5. Hopefully if every one is in agreement, we
can avoid patching for BCH support again when GPMC driver migration happens. And
the effect of GPMC driver migration on NAND driver can be reduced when it happens.

Can you try a patch on top of this series & checks if it works for you, if more is
required from my side let me know.

Regards
Afzal

[A] http://marc.info/?l=linux-omap&m=133675113218509&w=2
[B] http://marc.info/?l=linux-omap&m=133675123118577&w=2
[C] http://marc.info/?l=linux-omap&m=133675123718579&w=2
[D] http://marc.info/?l=linux-omap&m=133675124818580&w=2

