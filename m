From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Fri, 11 Jul 2014 09:59:42 +0200
Message-ID: <53BF996E.8020801@zonque.org>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:34047 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaGKH7p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2014 03:59:45 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, =?UTF-8?B?UGFzY2FsIEjDvHJzdA==?= <pascal.huerst@bluewin.ch>

On 07/11/2014 04:55 AM, Dave Gerlach wrote:
> This series adds suspend/resume support for am335x. Version 3 of this
> series can be found at [1]. I apologize for the large delay between this
> and the previous revision. This code has been heavily refined
> since the last version based on the various comments received for v3. The
> major change from previous version is moving all wkup_m3 code into a
> remoteproc based driver. The new driver handles all IPC and fw loading
> and exposes a small API to be used by PM code to achieve low power states.

Thanks a lot for this new series, Dave!

I've given it a quick test on a custom AM335x board and can confirm
success. Tested with both DDR2 and DDR3 versions, both work fine, and
power consumption drops to a reasonable level.

I'd be very happy if these patches made it in for 3.17, but I haven't
followed the discussion on the patches this set depends on.


Best regards,
Daniel

