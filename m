From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
	regions
Date: Fri, 19 Mar 2010 09:46:04 +0200
Message-ID: <20100319074604.GA19537@localhost>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com> <20100317173407.GD30422@localhost> <20100317201425.GI18243@nokia.com> <20100318085239.GE30422@localhost> <20100318152604.GM18243@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19205 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0CSHqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 03:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20100318152604.GM18243@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 18, 2010 at 04:26:04PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> [...]
> > > Just tried it and seems to be mostly OK. We get lockdep checking as a
> > > bonus. It didn't like setup_plane taking the same rwsem twice so I
> > > added a check to see if the old and new regions are the same and just
> > > lock once in that case. I thought rwsem was supposed to be OK with
> > > read recursion but perhaps I was mitaken, or perhaps it's just lockdep
> > > that's misbehaving.
> > 
> > Ah ok, so it's not so obvious change. Nested read locks could really lead
> > to a deadlock I think. A read lock will block if there is a write waiter
> > in the queue to avoid write starvation..
> 
> Yes but I think in out case it should be fine because if we hit this:
> 
>  t  thread 1     thread 2
>  |
>  |  down_read(0)
>  |               down_write(1)
>  v  down_read(1)
> 
> then thread 2 will eventually do a up_write() without taking any
> other region rwsem, and thread 1 can then continue.

Yes and things will work fine with the extra ordering you added. But
lockdep was right in that without the ordering you can get - the not
too likely - scenario:

t thread 1        thread 2       thread 3      thread 4
| down_read(0)
|                 down_write(0)
|                                down_read(1)
|                                              down_write(1)
| down_read(1)
v                                down_read(0)

--Imre

