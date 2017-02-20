From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
Date: Mon, 20 Feb 2017 14:00:49 +0530
Message-ID: <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Dinh Nguyen <dinguyen@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
> As DaVinci uses the standard suspend_valid_only_mem() for its
> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
> callback will never be called with state equal to PM_SUSPEND_STANDBY.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me. Whats the plan for applying the series. Do you want
the individual machine maintainers to apply their parts. Or some other?

Thanks,
Sekhar
