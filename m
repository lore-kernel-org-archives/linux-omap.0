From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: No OMAP PM code on the PM branch???
Date: Tue, 05 May 2009 07:54:34 -0700
Message-ID: <87ljpb4n2t.fsf@deeprootsystems.com>
References: <1241203145.18100.370.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:43380 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbZEEOyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 10:54:41 -0400
Received: by bwz22 with SMTP id 22so1322591bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2009 07:54:40 -0700 (PDT)
In-Reply-To: <1241203145.18100.370.camel@blackhole> (Peter Barada's message of "Fri\, 01 May 2009 14\:39\:05 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Peter Barada <peterb@logicpd.com> writes:

> I'm looking through Kevin's PM branch, and I've done a quick-port of
> 2.6.30-rc1 to Logic's OMAP3530 LV SOM starting with the rk21 board code,
> and "echo mem > /sys/power/state" does nothing.  Worse,
> "cat /sys/power/state" doesn't show anything.

Since 2.6.30, there is no OMAP PM code in linux-omap master branch.
The only working PM is now in the PM branch.

I am currently rebasing the PM branch to 2.6.30-rc series and it
should be published this week.

Kevin
