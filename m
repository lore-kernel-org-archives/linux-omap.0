From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 15:13:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211512570.4677@utopia.booyaka.com>
References: <1285079310-15888-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com> <878w2uj1tv.fsf@deeprootsystems.com> <alpine.DEB.2.00.1009211425530.4677@utopia.booyaka.com> <871v8mizb4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46476 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab0IUVNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 17:13:39 -0400
In-Reply-To: <871v8mizb4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

On Tue, 21 Sep 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > On Tue, 21 Sep 2010, Kevin Hilman wrote:
> >
> >> FWIW
> >> 
> >> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> >> 
> >> as I'm using this for testing the various hwmod conversions.
> >
> > Thanks Kevin, added that in.  I know you've been testing some of the other 
> > patches here too, so please let me know if you would like Tested-by:'s or 
> > Acked-by:'s there.
> 
> I guess you can put a Tested-by for me on everything in your
> hwmod_2.6.37 branch as I've been staging and testing those for a bit
> now.

OK, sounds good.  How about the updated hardreset code - have you given 
that a try?

> Also, one other thing I noticed in that branch: the locking patch from
> me:
> 
>    OMAP: hwmod: separate list locking and hwmod hardware locking
> 
> has a stray '[PATCH]' in the shortlog which should probably be removed
> as well.

Thanks, fixed.


- Paul
