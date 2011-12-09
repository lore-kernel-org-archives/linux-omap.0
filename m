From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after
	dpll1 reprogram
Date: Fri, 9 Dec 2011 08:42:45 +0000
Message-ID: <20111209084245.GB14547@n2100.arm.linux.org.uk>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl> <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59364 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1LIIn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 03:43:27 -0500
Content-Disposition: inline
In-Reply-To: <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Nov 29, 2011 at 01:25:32AM +0100, Janusz Krzysztofik wrote:
> However, the result of cpufreq_scale() differs from that of
> (re)calibrate_delay() by ca. 6%, i.e., 70.40 vs. 74.54. Please advise if
> this approximation is acceptable.

You don't say which figure is what.

Note that calibrate_delay() is itself inaccurate - the loops_per_jiffy
is the number of loops which can be executed between two timer ticks
_minus_ the time to process the timer interrupt itself.  So, it's
actually always a little less than the theoretical number of loops
within that time period.
