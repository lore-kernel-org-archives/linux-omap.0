From: Tony Lindgren <tony@atomide.com>
Subject: Re: Can i submit B&N Nook Color generic kernel support patches?
Date: Mon, 18 Apr 2011 15:25:57 +0300
Message-ID: <20110418122557.GM12272@atomide.com>
References: <BANLkTinCyzCzBUOTOCV5tQoQmxajpAH=MA@mail.gmail.com>
 <874o683jeo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21425 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab1DRMZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 08:25:59 -0400
Content-Disposition: inline
In-Reply-To: <874o683jeo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Abimanyu Gottumukkala <me@abimanyu.in>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110408 17:27]:
> Hello,
> 
> Abimanyu Gottumukkala <me@abimanyu.in> writes:
> 
> > I am working on porting B&N Nook color source to generic kernel (non
> > Android). Can i submit my ported code to omap-linux git?
> 
> Absolutely!
> 
> Support for new platforms is always welcome.  This platform is based on
> the OMAP36xx (3621 I think), so you might look at other 36xx-based
> platforms (like Zoom3) as a starting point for your platform support.
> 
> It will also be good to be familiar with the differences between a 3621
> and a 3630 and use OMAP features so any differences in the parts can be
> determined at runtime (see omap_has_* in <plat/cpu.h> for example.)

Adding support for new machines adds only a few tens of lines of
code in most cases, so that should not be a problem from code
consolidation point of view.

Regards,

Tony
