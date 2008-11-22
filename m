From: Paul Walmsley <paul@pwsan.com>
Subject: Re: MMC oops on BeagleBoard with pm-20081119
Date: Sat, 22 Nov 2008 11:50:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811221148060.28747@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811212036560.28747@utopia.booyaka.com> <200811212129.03222.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33126 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYKVSvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 13:51:01 -0500
In-Reply-To: <200811212129.03222.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Fri, 21 Nov 2008, David Brownell wrote:

> On Friday 21 November 2008, Paul Walmsley wrote:
> > This oops shows up shortly after logging in on BeagleBoard running 
> > pm-20081119; posting here in case anyone recognizes what's going on.
> > / is on a SanDisk SD Plus 4GB MMC card.
> 
> Just for the record, I'd suspect it *is* something in the pm-* patches
> since it doesn't show up on mine, running rc5-omap1.  Unless it's an
> intermittent booboo.

Hi,

Did some more testing here.  Whatever caused this appears to be resolved, 
after the application of the recent series:

http://marc.info/?l=linux-omap&m=122725894420248&w=2


- Paul
