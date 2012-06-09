From: Paul Walmsley <paul@pwsan.com>
Subject: RE: AM335x CPSW reset (was "RE: [PATCH 04/11] ARM: OMAP2+: usb_host_fs:
 add custom reset for usb_host_fs (fsusb)")
Date: Sat, 9 Jun 2012 10:05:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206091003580.17257@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com> <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA46087@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206081659230.17523@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA464C6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35605 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2FIQFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jun 2012 12:05:30 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA464C6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Sat, 9 Jun 2012, Hiremath, Vaibhav wrote:

> On Sat, Jun 09, 2012 at 04:40:03, Paul Walmsley wrote:
> > On Fri, 8 Jun 2012, Hiremath, Vaibhav wrote:
> > 
> > > So the approach I had taken is, I had implemented almost similar 
> > > function specific to cpsw and introduced flag called 
> > > HWMOD_SWSUP_RESET_BEFORE_IDLE.
> > 
> > Why "SWSUP" ? 
> 
> Since it was SW initiated reset assertion so I added this prefix.

Maybe just use HWMOD_RESET_BEFORE_IDLE.  The code use SWSUP to mean 
"software-supervised" in the context of idle.

> > > Now the question here would be, should we consider this IP bug or 
> > > integration bug? If it is integration bug, then isn't this device issue?
> > 
> > I don't know if it's a bug in either place, but it sounds like something 
> > that needs to be handled in the _am335x_disable_module() code in 
> > mach-omap2/omap_hwmod.c.
> 
> Yes, certainly it should be part of _am335x_disable_module().

Great. Care to send a patch?


- Paul
