From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 12:30:03 -0700
Message-ID: <200803201230.03729.david-b@pacbell.net>
References: <87d4pqqmj2.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:40051 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753772AbYCTTaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2008 15:30:09 -0400
In-Reply-To: <87d4pqqmj2.fsf@paris.hilman.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 19 March 2008, Kevin Hilman wrote:

> However, if I then plug the key back in, nothing happens.  
> 
> Forcing a session start via "echo 'F' > /proc/driver/musb_hdrc" causes
> the device to be (re)detected and things look good again.  It is not
> until I force the session start that I see the interrupt and the
> CONNECT event.
> 
> Any ideas why this isn't detected on insertion?

Just for the record ... that's always been a problem.  There's
some strange side-effect driven magic in the Mentor IP, right
in that area, which has always been fragile.

For example, it seems to think something other than the state
of the ID pin should control whether it's in the A-side state
machine (default host) or the B-side one (default peripheral),
and it gets fairly twitchey about VBUS levels too ... as in,
it doesn't allow the specified 100 msec for it to stabilize,
and enters a fault/shutdown mode if voltage drops because of,
say, contact bounce or inrush current, while it stabilizes.

Needing that "force session start" is a warning flag.  The
very notion of that kind of "session" is something introduced
by Mentor, which is not part of the OTG spec (at least, not in
anything like that form).  Multiple weeks have been wasted
trying to sort out misbehavior in that area, and there seem
to be revision-specific issues too.

- Dave


