From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] i2c-omap: Set latency requirements only once for several
 messages
Date: Fri, 3 Dec 2010 01:31:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030128490.17078@utopia.booyaka.com>
References: <1290074660-2640-1-git-send-email-samu.p.onkalo@nokia.com> <20101203023751.GF20097@trinity.fluff.org> <90C2C3D80A94B8448891D39FF568E87605D718DD@008-AM1MPN1-012.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224Ab0LCIbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 03:31:39 -0500
In-Reply-To: <90C2C3D80A94B8448891D39FF568E87605D718DD@008-AM1MPN1-012.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: ben-i2c@fluff.org, ben-linux@fluff.org, linux-i2c@vger.kernel.org, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

Hello Ben, Samu,

On Fri, 3 Dec 2010, samu.p.onkalo@nokia.com wrote:

> >-----Original Message-----
> >From: ext Ben Dooks [mailto:ben-i2c@fluff.org]
> >Sent: 03 December, 2010 04:38
> >To: Onkalo Samu.P (Nokia-MS/Tampere)
> >Cc: ben-linux@fluff.org; linux-i2c@vger.kernel.org;
> >khilman@deeprootsystems.com; paul@pwsan.com; linux-omap@vger.kernel.org
> >Subject: Re: [PATCH] i2c-omap: Set latency requirements only once for
> >several messages
> >
> >On Thu, Nov 18, 2010 at 12:04:20PM +0200, Samu Onkalo wrote:
> >> Ordinary I2C read consist of two messages. First a write operation
> >> to tell register address and then read operation to get data.
> >> CPU wake up latency is set and removed twice in read case.
> >> Set latency requirement before the message processing loop
> >> and remove the requirement after the loop to remove latency
> >> adjustment operations between the messages.
> >>
> >> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> >> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> >> Acked-by: Paul Walmsley <paul@pwsan.com>
> >
> >I'll queue this for -rc unless it is going in via the omap list
> >or it should wait for merge window?
> >
> 
> I first sent this to omap-list and I got instructions to send this to you.
> So I assume that you should queue this. Kevin, Paul, is -rc ok for you?

I'd suggest that this go in through Ben, and go in as part of the 2.6.38 
merge window, rather than the .37-rc.  The patch doesn't fix any 
regressions introduced in the 2.6.37 merge window, and there's no impact 
on system stability, as far as I know.


- Paul
