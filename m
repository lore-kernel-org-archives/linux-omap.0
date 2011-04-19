From: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Subject: Re: The old omapfb support
Date: Tue, 19 Apr 2011 14:34:45 +0200
Message-ID: <1303216485.27432.7.camel@maggie>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:40285 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab1DSMex (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 08:34:53 -0400
In-Reply-To: <20110419123036.GF15620@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, lo-ml <linux-omap@vger.kernel.org>

On Tue, 2011-04-19 at 15:30 +0300, Tony Lindgren wrote: 
> > But this again reminded me of the mess of having two display drivers,
> > the old omapfb and the new DSS2. Many of the OMAP2 boards using the old
> > driver should be quite easy to port to DSS2, with the exception of N800.
> > DSS2 doesn't support OMAP1, so there's not much that can be done with
> > those boards currently.

> Yeh we can just make old omapfb depends on ARCH_OMAP1.

As he said, the old omapfb code is used on n8x0, which is OMAP2.

-- 
Greetings Michael.

