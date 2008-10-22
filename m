From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] alsa: add beagleboard SoC configuration.
Date: Wed, 22 Oct 2008 12:36:38 -0700
Message-ID: <200810221236.38336.david-b@pacbell.net>
References: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com> <20081022165300.GX7341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34499 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753132AbYJVTgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 15:36:43 -0400
In-Reply-To: <20081022165300.GX7341@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

On Wednesday 22 October 2008, Tony Lindgren wrote:
> This should go to alsa-devel list with l-o list cc'd. AFAIK, all
> the omap ASoC stuff is in mainline already. I will not push it
> to l-o until we have an ack from alsa-devel.

There are multiple ASoc bits ... they're not all there yet.
The TWL4030 codec support should be ready to go, now that its
core has merged, plus Overo (and "soon" Beagle) board support.

The twl4030-core support was the blocking issue; at least some
of the other patches were even acked.

  http://marc.info/?t=122304728600007&r=1&w=2

Maybe Steve would resubmit his patches, to merge through ALSA
into 2.6.28-rc?  I presume all the feedback from his first round
(beginning of September) got addressed.  

- Dave
