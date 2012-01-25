From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP: DSS PM fixes
Date: Wed, 25 Jan 2012 11:55:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251154360.5324@utopia.booyaka.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com> <1327478645.1858.17.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44561 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab2AYSze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 13:55:34 -0500
In-Reply-To: <1327478645.1858.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi,

sorry about the delay,

On Wed, 25 Jan 2012, Tomi Valkeinen wrote:

> On Mon, 2012-01-23 at 14:15 +0200, Tomi Valkeinen wrote:
> > Here are two fixes to get DSS work better with PM on OMAP3.

...

> > The two fixes are independent, so either I can take them through dss tree (with
> > appropriate Acks), or the hwmod patches can go through some other tree.
> 
> Ping. Sorry to be hurrying with this, but I'd like to get these into the
> next rc. Can you ack these (perhaps the first two patches?) or do you
> want to take them through your tree?

I'll take the two hwmod data changes through my tree here & will plan to 
send a pull request today.


regards

- Paul
