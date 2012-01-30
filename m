From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: miscellaneous powerdomain-related improvements
Date: Mon, 30 Jan 2012 13:27:11 -0800
Message-ID: <871uqgswy8.fsf@ti.com>
References: <20120130093931.11027.31048.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37695 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220Ab2A3V1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 16:27:16 -0500
Received: by mail-gy0-f182.google.com with SMTP id g15so2226162ghb.13
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 13:27:15 -0800 (PST)
In-Reply-To: <20120130093931.11027.31048.stgit@dusk> (Paul Walmsley's message
	of "Mon, 30 Jan 2012 02:43:12 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tero Kristo <t-kristo@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> This series optimizes some of the powerdomain-related code in
> arch/arm/mach-omap2/pm*, and fixes a bug or two.  These were noticed while
> working on the functional powerstate code.
>
> Rajendra and Santosh, if you have a spare moment, could you please
> peek at the OMAP4 LOWPOWERSTATECHANGE part of the second patch?  It
> makes sense to me in theory, but you both would probably know better
> than I :-)
>
> Kevin, want to take this series (assuming folks are happy with it) ?

Yes, I'll take this and add the Ack from Santosh.  Thanks for the nice
cleanup.   

Will submit after seeing a Tested-by from someone who can test with CORE
retention/off on OMAP4 (hint, hint,  Tero :)

Kevin
