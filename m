From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] OMAPDSS: Misc improvements
Date: Fri, 7 Sep 2012 09:22:58 -0700
Message-ID: <20120907162258.GT1303@atomide.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1346743368.2586.1.camel@deskari>
 <20120906201330.GF1303@atomide.com>
 <1347012960.2646.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:34964 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750777Ab2IGQXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 12:23:00 -0400
Content-Disposition: inline
In-Reply-To: <1347012960.2646.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120907 03:16]:
> On Thu, 2012-09-06 at 13:13 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120904 00:23]:
> > > Hi Tony,
> > > 
> > > Can you check the arch/arm patches below, and suggest how you'd like to
> > > go forward with them?
> > 
> > Acked them, then as soon as we have the initial immutable header
> > move branch available, you should merge with that to avoid
> > merge conflicts in upstream.
> 
> Thanks, but you missed the first patch "[PATCH 1/8] OMAPDSS: HDMI: Move
> GPIO handling to HDMI driver".

Oops sorry, that's a nice one, acked that too. BTW, do you have any
platform code callbacks remaining for DSS?

Regards,

Tony
