From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 00:53:00 +0300
Message-ID: <20080825215258.GF14939@frodo>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com> <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com> <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com> <20080825213510.GC14939@frodo> <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56560 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYHYVxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 17:53:25 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: me@felipebalbi.com, Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 25, 2008 at 02:50:04PM -0700, Steve Sakoman wrote:
> >> ALSA sound/core/pcm_native.c:2573: BUG? (substream != ((void *)0))
> >
> > Hmmm... this looks odd.
> >
> > Jarkko, shouldn't that snd_assert() in pcm_native.c check if substream
> > _is_ NULL instead of !is NULL ?
> 
> I found this odd also, but looking in
> Documentation/sound/alsa/DocBook/writing-an-alsa-driver I found that
> the sense of the test is indeed the reverse of what you would expect
> -- you are specifying the condition that *should* be met, and the
> action to take if it is not.
> 
> I can also verify that the substream pointer is indeed null -- the
> reason I enabled alsa debugging in the first place is that the kernel
> was crashing due to a null pointer :-)

Hmm, so the crash is actually somewhere else. Could you disable debug
and get the NULL pointer dereference at the right point ?

I think it'll be easier to track down, maybe.

-- 
balbi
