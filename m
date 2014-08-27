From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10] ARM: OMAP5 / DRA7: Add framework for suspend and cpuidle
Date: Wed, 27 Aug 2014 12:15:06 -0700
Message-ID: <7htx4xbv7p.fsf@paris.lan>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408716154-26101-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 22 Aug 2014 09:02:24 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, daniel.lezcano@linaro.org
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> The following series are various fixes and improvements for
> supporting suspend-to-ram. This depends on the following for basic functionality:
> series 1/6 where powerdomain fixes were involved.

I had a look through this series, and it looks good overall.  I think Daniel
needs to weigh in on the CPUidle driver, otherwise.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

I also tested on omap5uevm with the pm_debug/wakeup_timer_seconds patch.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
