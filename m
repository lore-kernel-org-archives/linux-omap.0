From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Tue, 30 Sep 2008 16:43:30 +0300
Message-ID: <20080930134330.GD2492@gandalf.research.nokia.com>
References: <20080925094718.GE5222@atomide.com> <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl> <20080925103952.GJ5222@atomide.com> <5e088bd90809250824q38fb95e0q7a9e3f8a24a4d845@mail.gmail.com> <20080926074208.GC7962@atomide.com> <20080926111351.GA8736@atomide.com> <20080928124641.GB8254@atomide.com> <20080930125838.GA15828@atomide.com> <20080930132222.GC2492@gandalf.research.nokia.com> <20080930133550.GA15017@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23703 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYI3Nog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 09:44:36 -0400
Content-Disposition: inline
In-Reply-To: <20080930133550.GA15017@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Steve Sakoman <sakoman@gmail.com>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Sep 30, 2008 at 04:35:51PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080930 16:22]:
> > On Tue, Sep 30, 2008 at 03:58:39PM +0300, Tony Lindgren wrote:
> > > + * One controller can have multiple slots, like on some omap boards using
> > > + * omap.c controller driver. Luckily this is not currently done on any known
> > > + * omap_hsmmc.c device.
> > 
> > this is only true for omap1 afaict.
> 
> Do you mean omap.c but not on omap_hsmmc.c?
> 
> If for sure we'll never have multiple slots on omap_hsmmc.c, we could simplify
> the code and assume the slot is always 0.

Yeah, looks like multislot is only useful for 2420 (h4 and n8x0).

-- 
balbi
