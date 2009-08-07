From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM: UART not resuming from OFF mode
Date: Fri, 07 Aug 2009 09:21:07 -0700
Message-ID: <87k51f4mto.fsf@deeprootsystems.com>
References: <4A7BEC0A.9030909@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:39320 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbZHGQVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 12:21:09 -0400
Received: by wf-out-1314.google.com with SMTP id 26so665007wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 09:21:10 -0700 (PDT)
In-Reply-To: <4A7BEC0A.9030909@nokia.com> (Roger Quadros's message of "Fri\, 07 Aug 2009 11\:55\:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Roger Quadros <ext-roger.quadros@nokia.com> writes:

>  I'm facing this strange problem since some days. I have 3 identical
> boards using OMAP3430 ES3.1 and I'm using Kevin's PM
> tree. http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=pm
>
> The problem is that UART3 fails to operate correctly after OFF mode on
> _two_ of the boards but works on one. It seems to receive characters
> but 0 only. So characters do not show up on terminal.
>
> Is anybody experiencing similar problems with UART and off mode on your boards?

Is this after suspend-to-OFF or OFF-while-idle?

I've experienced this with UART1 on SDP ES3.0, but according to
Rajendra it didn't happen on SDP ES3.1 (I don't currently have any
ES3.1 hardware) :(

Are all of yours ES3.1 ?

I haven't tracked it further since I only saw it on my SDP with UART1
and not on any other board.

Kevin



