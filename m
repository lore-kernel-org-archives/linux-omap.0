From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: vdds_dsi doesn't exist on all omap3430 arch chip
Date: Thu, 4 Mar 2010 21:30:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DC534C4@dbde02.ent.ti.com>
References: <4B8F8B76.9050807@windriver.com>
 <1267699040.2406.115.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33572 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab0CDQAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 11:00:54 -0500
In-Reply-To: <1267699040.2406.115.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "ext stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Thursday, March 04, 2010 4:07 PM
> To: ext stanley.miao
> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-omap@vger.kernel.org
> Subject: Re: vdds_dsi doesn't exist on all omap3430 arch chip
> 
> Hi,
> 
> On Thu, 2010-03-04 at 11:29 +0100, ext stanley.miao wrote:
> > Hi, Tomi,
> >
> > The commit below:
> > http://www.gitorious.org/linux-omap-
> dss2/linux/commit/ec70668fa99b2dd0d305fbdb451a728f2e2a4c58
> > doesn't apply to ti_omap_am3517. There is no "vdds_dsi" on am3517.
> 
> DSS hardware seems to require vdds_dsi power on OMAP3 chips. You need to
> add it to the board file's regulator configuration. Or do you mean that
> on am3517 there's no power connected to OMAP's vdds_dsi line?
> 
[Hiremath, Vaibhav] Tomi,

Currently we do have only one EVM for AM3517 available in the market and which doesn't support DSI interface, so there is no DSI power source available or required. Also the power chip being used is low cost which doesn't have these many sources available. 

At-least for our internal release, the quick solution I did is, I have encapsulated the regulator_* API calls under !cpu_is_omap3517() && !cpu_is_omap3505().

The ideal solution would be to take the input from board hook up part for power supply also, that way we can support OMAP3 based various EVM's where we have different power chip. Since I am busy with some other high priority issues, I will be able to take this up after this only.


Thanks,
Vaibhav

>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
