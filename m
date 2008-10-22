From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Wed, 22 Oct 2008 19:33:57 +0300
Message-ID: <20081022163357.GI23142@gandalf.research.nokia.com>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <200810181228.09194.david-b@pacbell.net> <20081018194304.GP31842@frodo> <200810181316.51253.david-b@pacbell.net> <20081018203625.GR31842@frodo> <386072610810220835s2fe78519s7eaa7bb00585c684@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44632 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbYJVQec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 12:34:32 -0400
Content-Disposition: inline
In-Reply-To: <386072610810220835s2fe78519s7eaa7bb00585c684@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <cooloney@kernel.org>
Cc: me@felipebalbi.com, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 22, 2008 at 11:35:16PM +0800, Bryan Wu wrote:
> >
> >> Right.  Does Blackfin have an integrated transceiver like
> >> DaVinci and TUSB?  Or does it use a discrete one?
> >
> > I'll revisit the blackfin patches, they're going only for 2.6.29 merge
> > window.
> >
> 
> Hi Felipe, is it possible to push blackfin patches in the 2.6.28?
> because we are planning to use 2.6.28 stable release as our 2009R1 release.
> 
> If the usb part are merged, it is much easier for me to do the release.

If greg accept the patches in 2.6.28-rc, yes :-)

-- 
balbi
