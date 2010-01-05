From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH] rtc: make rtc-omap wakeup capable
Date: Tue, 5 Jan 2010 13:46:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E1D31301@dbde02.ent.ti.com>
References: <1259068720-26113-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34243 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252Ab0AEIQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 03:16:41 -0500
In-Reply-To: <1259068720-26113-1-git-send-email-nsekhar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>
Cc: "Davinci-linux-open-source@linux.davincidsp.com" <Davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Hello,

On Tue, Nov 24, 2009 at 18:48:40, Nori, Sekhar wrote:
> The rtc-omap driver currently hardcodes the RTC to be
> not capable of wakeup events. On the DA850/OMAP-L138
> SoC, the RTC is a wake up source from its "deep sleep"
> mode.
>
> Let platform data set the wakeup capability flag instead.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Any comments on this patch?

Thanks,
Sekhar

