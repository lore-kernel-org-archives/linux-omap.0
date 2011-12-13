From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/6] OMAP2+: omap_hwmod: manage the wake-up latency constraints
Date: Tue, 13 Dec 2011 15:46:47 -0800
Message-ID: <87hb14t4pk.fsf@ti.com>
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
	<1323706701-6627-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:45867 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909Ab1LMXqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 18:46:52 -0500
Received: by mail-yw0-f47.google.com with SMTP id o47so954472yho.34
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 15:46:51 -0800 (PST)
In-Reply-To: <1323706701-6627-3-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 12 Dec 2011 17:18:17 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Hwmod is queried from the OMAP_PM layer to manage the power domains

nit: changelog needs a refresh as this isn't called from OMAP PM layer.

> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Kevin
