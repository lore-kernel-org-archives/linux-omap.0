From: Kevin Hilman <khilman@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Mon, 14 May 2012 15:48:11 -0700
Message-ID: <87mx5apefo.fsf@ti.com>
References: <1336033721.14378.2.camel@deskari>
	<WC20120503084938.900446@terrafix.co.uk>
	<1336050442.14378.10.camel@deskari>
	<WC20120504091902.970499@terrafix.co.uk>
	<1336139415.2552.4.camel@deskari> <1336140072.2552.6.camel@deskari>
	<WC20120504140943.7604D0@terrafix.co.uk>
	<1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	<1336483598.5761.45.camel@deskari>
	<WC20120514073642.6306D7@terrafix.co.uk>
	<1336982138.2532.32.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:37942 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757964Ab2ENWsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 18:48:14 -0400
Received: by pbbrq13 with SMTP id rq13so7583057pbb.36
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 15:48:13 -0700 (PDT)
In-Reply-To: <1336982138.2532.32.camel@lappyti> (Tomi Valkeinen's message of
	"Mon, 14 May 2012 10:55:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Mon, 2012-05-14 at 08:36 +0100, Joe Woodward wrote:
>> Any news on this?
>> 
>> This thread seems to have gone a little quiet...
>
> Hi,
>
> I've been doing testing to understand the problem, but so far I don't
> have any idea why things go wrong. I haven't found out any logic in
> which configuration works and which doesn't. Looks to me that for some
> reason the PM prevents DSS from getting data fast enough with certain
> fifo thresholds.
>
> I have two ways to avoid the problem, but I've been reluctant to make
> patches for those because I feel it's just hiding the problem. One way
> is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
> other is to use certain fifo threshold values, which just seem to work
> for unknown reasons.
>
> Considering that we already have a SIDLEMODE hack in DSS for omap3 when
> using DSI, I wonder if the omap3 PM + DSS combination is just plain
> broken, and we should disallow idle. I'm not quite sure what are the
> implications of that.
>
> I'd appreciate comments from the PM people =).

Unfortunately, without the bandwidth to dig into this deeply myself, I
don't have much to add.

As we know, it's not unheard of for various IPs to have bugs in
smart-idle mode ;)

The one thing I can say is that the reason it probably worked on earlier
kernels was because the UART driver was not actually idling, so you were
probably never hitting low power states.  

Kevin

