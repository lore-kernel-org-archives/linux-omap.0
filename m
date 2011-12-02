From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv7 3/7] omap3: voltage: fix channel configuration
Date: Fri, 02 Dec 2011 15:55:13 -0800
Message-ID: <87pqg6jzq6.fsf@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	<1322492005-27741-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:39513 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab1LBXzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 18:55:17 -0500
Received: by mail-iy0-f176.google.com with SMTP id k10so6755938iag.35
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 15:55:16 -0800 (PST)
In-Reply-To: <1322492005-27741-4-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 28 Nov 2011 16:53:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

Tero Kristo <t-kristo@ti.com> writes:

> OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
> overlap with VDD2 and attempting to modify VDD1 voltage will actually change
> VDD2 voltage.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

I've forgotten a bit how this was supposed to work (again), Can you
elaborate more on how this fails?

Setting the OMAP_VC_CHANNEL_DEFAULT flag makes sense to me, but the
other change doesn't.

Kevin
