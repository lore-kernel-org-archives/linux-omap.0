From: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Subject: Re: The old omapfb support
Date: Wed, 20 Apr 2011 13:18:00 +0200
Message-ID: <1303298280.12837.2.camel@maggie>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
	 <1303286810.2102.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:47372 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab1DTLSJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 07:18:09 -0400
In-Reply-To: <1303286810.2102.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, lo-ml <linux-omap@vger.kernel.org>

On Wed, 2011-04-20 at 11:06 +0300, Tomi Valkeinen wrote: 
> > So if you first port the stuff and then add the depends-on OMAP1, I'm
> > fine with it.
> 
> Does the display even work on N8x0 with mainline kernel? I don't see any
> code for it in the board file.

It needs some additional glue code, which can be found here:
https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2.6.38/301-nokia-board-additional.patch
But with that code it works fine.

-- 
Greetings Michael.

