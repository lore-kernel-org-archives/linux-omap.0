From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: vdds_dsi doesn't exist on all omap3430 arch chip
Date: Fri, 5 Mar 2010 09:25:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DC53538@dbde02.ent.ti.com>
References: <4B8F8B76.9050807@windriver.com>
	 <1267699040.2406.115.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DC534C4@dbde02.ent.ti.com>
 <1267719310.25148.51.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38605 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab0CED4K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 22:56:10 -0500
In-Reply-To: <1267719310.25148.51.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "ext stanley.miao" <stanley.miao@windriver.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, March 04, 2010 9:45 PM
> To: Hiremath, Vaibhav
> Cc: ext stanley.miao; linux-fbdev-devel@lists.sourceforge.net; linux-
> omap@vger.kernel.org
> Subject: RE: vdds_dsi doesn't exist on all omap3430 arch chip
> 
> On Thu, 2010-03-04 at 17:00 +0100, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> > > Sent: Thursday, March 04, 2010 4:07 PM
> > > To: ext stanley.miao
> > > Cc: linux-fbdev-devel@lists.sourceforge.net; linux-omap@vger.kernel.org
> > > Subject: Re: vdds_dsi doesn't exist on all omap3430 arch chip
> > >
> > > Hi,
> > >
> > > On Thu, 2010-03-04 at 11:29 +0100, ext stanley.miao wrote:
> > > > Hi, Tomi,
> > > >
> > > > The commit below:
> > > > http://www.gitorious.org/linux-omap-
> > > dss2/linux/commit/ec70668fa99b2dd0d305fbdb451a728f2e2a4c58
> > > > doesn't apply to ti_omap_am3517. There is no "vdds_dsi" on am3517.
> > >
> > > DSS hardware seems to require vdds_dsi power on OMAP3 chips. You need to
> > > add it to the board file's regulator configuration. Or do you mean that
> > > on am3517 there's no power connected to OMAP's vdds_dsi line?
> > >
> > [Hiremath, Vaibhav] Tomi,
> >
> > Currently we do have only one EVM for AM3517 available in the market and
> which doesn't support DSI interface, so there is no DSI power source
> available or required. Also the power chip being used is low cost which
> doesn't have these many sources available.
> >
> > At-least for our internal release, the quick solution I did is, I have
> encapsulated the regulator_* API calls under !cpu_is_omap3517() &&
> !cpu_is_omap3505().
> >
> > The ideal solution would be to take the input from board hook up part for
> power supply also, that way we can support OMAP3 based various EVM's where
> we have different power chip. Since I am busy with some other high priority
> issues, I will be able to take this up after this only.
> 
> Hmm okay, so what is AM3517 exactly =)?
> 
> An OMAP-like SoC, with the same DSS block as on OMAP?
[Hiremath, Vaibhav] Yes, this is an OMAP-like SoC with some new IP addition and some got removed. But the DSS block is exactly same as OMAP3.

> 
> I think this power issue should be asked from some TI HW guy who can
> tell us what is going on there. If OMAP3430 requires vdds_dsi power to
> power all the pins (and this is still unclear, although it is the
> current assumption), then which OMAP variants need the power and which
> do not?
> 
[Hiremath, Vaibhav] I will take this issue and explore more on this, but as I said will be able to spend time after next week only.

> Also something related I've been wondering: Different OMAP versions have
> different DSS features. Currently we check these features by checking
> what OMAP version we're running on.
> 
> But there is a readable revision number in the DSS HW blocks, and if
> that could be used to choose which features are available, it'd be a
> much better solution. TRM doesn't mention these revision numbers. I
> wonder if TI has a list of DSS revisions...
[Hiremath, Vaibhav] Yes you are right, TRM doesn't talk about it. I will try to get further details on this.

Thanks,
Vaibhav

> 
>  Tomi
> 

