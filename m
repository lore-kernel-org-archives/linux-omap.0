From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [alsa-devel] [PATCH 2/4] OMAP: mcbsp - add smart idle configuration API
Date: Tue, 18 May 2010 16:01:47 -0700
Message-ID: <87tyq4lspw.fsf@deeprootsystems.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47405 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0ERXBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 19:01:50 -0400
Received: by pva18 with SMTP id 18so671749pva.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 16:01:49 -0700 (PDT)
In-Reply-To: <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk> (Liam Girdwood's message of "Tue\, 18 May 2010 21\:13\:12 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Liam Girdwood <lrg@slimlogic.co.uk> writes:

> Add a small API to configure McBSP smart idle modes
> to conserve power.

Would be useful here to explain why client drivers need to change
idle modes.

Also, this patch is telling me that it's time the McBSP is converted
over to the omap_hwmod/omap_device infrastructure where this type
of functionality would already be provided.

Not necesssarily a reason to prevent this patch for now, but this
will all need to be changed when converted to hwmod.

Kevin
