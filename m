From: Brian Swetland <swetland@google.com>
Subject: Re: Android on N810 File System Problem
Date: Wed, 30 Apr 2008 03:20:36 -0700
Message-ID: <20080430102036.GA23558@bulgaria.corp.google.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com> <20080425183605.GA27479@kedavra.cpe.vivax.com.br> <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br> <20080428233827.GE8449@atomide.com> <20080429090032.GA25363@bulgaria.corp.google.com> <87bq3ry8o7.fsf@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:39123 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759415AbYD3KV0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 06:21:26 -0400
Content-Disposition: inline
In-Reply-To: <87bq3ry8o7.fsf@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

[Kalle Valo <kalle.valo@nokia.com>]
> Brian Swetland <swetland@google.com> writes:
> >
> > This was the show-stopper for me.  When I last got things hobbling
> > along on n8x0, the binary-only wlan module was incompatible with
> > newer kernels than 2.6.21 (changes in some network data structures).
> 
> That's exactly the problem. I have written something about it here:
> 
> https://garage.maemo.org/pipermail/cx3110x-devel/2007-December/000007.html

Just did a quick diff between v2.6.21 and v2.6.24 and the skbuff changes
are pretty daunting.  Doesn't look like there's an easy hack here...

> Currently there's nothing I can do to resolve the issue, unfortunately.

Pity.  It'd be nice to get newer kernels running on the n8x0 -- it's
nice hardware.

Brian
