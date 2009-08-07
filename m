From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: MMC3 Overo
Date: Fri, 7 Aug 2009 06:24:51 -0700
Message-ID: <5e088bd90908070624g5bdcf8e4hc129a5a67d0d435@mail.gmail.com>
References: <4A79C83E.9040603@deeprootsystems.com>
	 <4A79D104.60607@deeprootsystems.com>
	 <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
	 <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
	 <871vnp8170.fsf@deeprootsystems.com> <4A7AF213.6040301@balister.org>
	 <1249574990.10885.43.camel@blitz> <20090807082115.GY2358@atomide.com>
	 <4A7BF2D2.7060608@nt.tu-darmstadt.de>
	 <20090807095528.GC2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:56493 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbZHGNYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 09:24:51 -0400
Received: by qyk34 with SMTP id 34so1472934qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 06:24:51 -0700 (PDT)
In-Reply-To: <20090807095528.GC2358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vladimir Pantelic <pan@nt.tu-darmstadt.de>, Peter Barada <peterb@logicpd.com>, Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 7, 2009 at 2:55 AM, Tony Lindgren<tony@atomide.com> wrote:

> Well we need to mux all the pins that can potentially conflict only in the
> board-*.c files.
>
> For naming, I think we should use the default mode0 name in the mux register as the
> key, and then link package specific pin names to that key. The pin names are
> very handy to see for debugging at least.

I like that approach - it matches the method in the documentation
tables (i.e. unique pin name is the mode 0 function).

> Another thing to consider is if we want to support dynamic muxing. That means
> we need to keep the mux tables in the memory.

Dynamic muxing would be very nice.  It is required if we ever want to
do card detect with microSD cards.

> Or do init time muxing in board-*.c files, then re-register the pins needed for
> dynamic muxing in board-*.c files. That way most of the mux data can be __initdata,
> and only the pins that have been registered for dynamic muxing need to be kept
> in the memory.

This sounds good too.

Reagrds,

Steve
