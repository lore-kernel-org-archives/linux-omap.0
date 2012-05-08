From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Tue, 8 May 2012 17:00:28 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1AEC8@DBDE01.ent.ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
 <20120507191847.GJ5088@atomide.com> <20120507193500.GK5088@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA18A6A@DBDE01.ent.ti.com>
 <20120508154829.GS5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52420 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695Ab2EHRAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:00:42 -0400
In-Reply-To: <20120508154829.GS5088@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Tue, May 08, 2012 at 21:18:29, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120507 22:52]:
> > On Tue, May 08, 2012 at 01:05:01, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [120507 12:22]:
> > > > * Paul Walmsley <paul@pwsan.com> [120507 12:11]:
> > > > > Hi,
> > > > > 
> > > > > On Fri, 4 May 2012, Tony Lindgren wrote:
> > > > > 
> > > > > > How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> > > > > > Then this becomes just:
> > > > > > 
> > > > > > #ifdef CONFIG_SOC_OMAP3PLUS
> > > > > 
> > > > > We might want to consider having separate CONFIG_SOC_* values for each 
> > > > > SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
> > > > > CONFIG_SOC_OMAP3630, etc.
> > > > 
> > > > Hmm but this would be in addition to the SOC specific options. The goal
> > > > is to cut down the ifdeffery needed all over the place to add new SoCs,
> > > > see the experimental patch I posted:
> > > > 
> > > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html
> > > 
> > > Of course we could make this finer grained based on features
> > > like SOC_HAS_XYZ or SOC_HAS_OMAP3PLUS_PRMXYZBITS if you have some
> > > grouping like that in mind.
> > > 
> > 
> > This is much better approach than both ARCH_OMAPx and SOC_OMAPxxxx.
> 
> OK good, so now the question is just what groupings we need.. Got any
> suggestions?
> 

Tony

I have submitted first round of cleanup patches in the same direction, can 
you please take a look at them? Most of them are trivial and should be 
considered for upstream.

I am trying to take cleanup thing one-by-one, and keep submitting them. 
Please let me know if you have any suggestions or pointers for me.

Thanks,
Vaibhav
