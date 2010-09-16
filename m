From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg
 detection)
Date: Thu, 16 Sep 2010 10:40:36 -0700
Message-ID: <20100916174036.GB29610@atomide.com>
References: <4C90F46D.2020902@artecdesign.ee>
 <AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
 <20100916060731.GB3393@legolas.emea.dhcp.ti.com>
 <AANLkTi=jyrLHTKSP1UTxNzri2EHvkt8iXT1cW8LKNNM6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52711 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0IPRko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:40:44 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=jyrLHTKSP1UTxNzri2EHvkt8iXT1cW8LKNNM6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: balbi@ti.com, Anti Sullin <anti.sullin@artecdesign.ee>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

* Steve Sakoman <sakoman@gmail.com> [100916 05:48]:
> 
> Agreed.  Gumstix doesn't provide an easy way of determining the layout
> revision via software (the boards are marked with the rev number, but
> that doesn't do much good!).

Unless you use the camera interface during early init to detect that
revision printed on the circuit board ;)
 
> I'm investigating methods to figure this out, but haven't yet found
> anything reliable.  When I do I'll post a patch.

How about add something to u-boot that allows setenv system_rev in
u-boot? Maybe it already has this feature as system_rev is arm-linux
generic atag.

Regards,

Tony
