From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 08 Mar 2012 13:21:57 -0800
Message-ID: <87d38mbxfu.fsf@ti.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	<alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	<CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	<87sjhjaqyi.fsf@ti.com> <1331232433.18015.69.camel@cumari>
	<alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
	<1331233547.18015.74.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:52477 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752630Ab2CHVV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 16:21:58 -0500
Received: by mail-yx0-f174.google.com with SMTP id l12so655801yen.5
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 13:21:57 -0800 (PST)
In-Reply-To: <1331233547.18015.74.camel@cumari> (Luciano Coelho's message of
	"Thu, 08 Mar 2012 21:05:47 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

Luciano Coelho <coelho@ti.com> writes:

[...]

> Thanks, Paul! I was just chatting with Kevin about this on IRC.  With
> your patch and no_console_suspend, it works. :)

Just FYI... I've queued this patch from Paul and it's now queued by Tony
for v3.4 in his cleanup-pm branch.

Kevin
