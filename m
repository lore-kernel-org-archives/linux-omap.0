From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Tue, 8 May 2012 12:06:51 -0700
Message-ID: <20120508190651.GB5088@atomide.com>
References: <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
 <871un1j769.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA1409D@DBDE01.ent.ti.com>
 <20120504200547.GU5613@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1778E@DBDE01.ent.ti.com>
 <20120507173229.GA5088@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA17EEC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23964 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab2EHTGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 15:06:55 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA17EEC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120507 11:59]:
> On Mon, May 07, 2012 at 23:02:29, Tony Lindgren wrote:
> > * Hiremath, Vaibhav <hvaibhav@ti.com> [120507 07:41]:
> > > On Sat, May 05, 2012 at 01:35:47, Tony Lindgren wrote:
> > > > 
> > > > I suggest doing some clean-up patches before adding SOC_AM33XX where
> > > > you just convert those to be
> > > > 
> > > > #if defined(CONFIG_ARCH_OMAP2PLUS) && !defined(CONFIG_ARCH_OMAP2)
> > > > 
> > > > or something similar depending if they already are inside mach-omap2
> > > > directory. This will make them future proof for adding new SoCs
> > > > without having to patch all over the place.
> > 
> > BTW, just noticied that the above won't work the right way in the
> > multi-omap case when all of them are compiled in..
> > 
> > > Cool, I also thought exactly same solution on this, but next thought came to 
> > > my mind was, it won't scale up, since we still have dependency on ARCH_OMAP2 
> > > option. However, it will be a good temporary solution for our problem, lets 
> > > review them first (I will submit shortly).
> > 
> > ..so probably the best way to deal with that is with the additional
> > CONFIG_SOC_OMAP3PLUS and CONFIG_SOC_OMAP4PLUS options that I posted
> > at:
> > 
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html
> > 
> > Can you please take a look and see how that works for am33xx?
> > 
> 
> I still don't understand, how this will help am33xx, and for that matter any 
> new future devices based on cortex-a8 or a9 core, but not omap exactly 
> families? 
> As I said earlier, am33xx doesn't fall under either omap3 or omap4; we have 
> again same question in front of us, which to follow, either omap3 or omap4??
> 
> What is the thought process of creating these config options? Isn't it same 
> as just replacing ARCH_OMAP3/4 with SOC_OMAP3PLUS and SOC_OMAP4PLUS? What is 
> the criteria for the device to get into this umbrella?

Just to recap: As we've discussed elsewhere, these new options need to be finer
grained SOC_HAS_OMAPXYZ_ABC type options like you've already posted.

Tony
