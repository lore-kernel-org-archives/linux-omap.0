From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: musb otg changes break booting on omaps
Date: Tue, 23 Jun 2009 19:10:40 +0300
Message-ID: <20090623161040.GC23234@nokia.com>
References: <20090623125700.GM7352@atomide.com>
 <19F8576C6E063C45BE387C64729E739404327A1514@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59282 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354AbZFWQMk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 12:12:40 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404327A1514@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@atomide.com" <linux-usb@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jun 23, 2009 at 03:20:19PM +0200, ext Gupta, Ajay Kumar wrote:
> 
> > Looks like commit 84e250ffa76dddc1bad84e04248a27f442c25986
> > "musb: proper hookup to transceiver drivers" breaks booting on omaps
> > if no transceiver is configured. Got any patches for that?
> 
> Tony,
> 
> Is this on OMAP35x EVM? If so then the below patch should help.
> 
> http://marc.info/?l=linux-omap&m=123907915211910&w=2

and omap3x30-based hardware will most likely use twl4030-usb and in some
cases (like evm) use the no-op trasceiver.

-- 
balbi
