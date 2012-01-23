From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: use sync versions of pm_runtime_put
Date: Mon, 23 Jan 2012 14:33:51 -0800
Message-ID: <87d3aakq0g.fsf@ti.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
	<1327320930-14550-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51628 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753347Ab2AWWdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 17:33:55 -0500
In-Reply-To: <1327320930-14550-4-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Mon, 23 Jan 2012 14:15:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, jw@terrafix.co.uk

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> omapdss doesn't work properly on system suspend. The problem seems to be
> the fact that omapdss uses pm_runtime_put() functions when turning off
> the hardware, and when system suspend is in process only sync versions
> are allowed.
>
> Using non-sync versions normally and sync versions when suspending would
> need rather ugly hacks to convey the information of
> suspending/not-suspending to different functions. Optimally the driver
> wouldn't even need to care about this, and the PM layer would handle
> syncing when suspend is in process.
>
> This patch changes all omapdss's pm_runtime_put calls to
> pm_runtime_put_sync. This fixes the suspend problem, and probably the
> performance penalty of always using sync versions is negligible.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
