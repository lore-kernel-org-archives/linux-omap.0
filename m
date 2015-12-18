From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/9] ARM: OMAP2+: omap_device: create clock alias purely
 from DT data
Date: Fri, 18 Dec 2015 07:16:50 -0800
Message-ID: <20151218151650.GI23396@atomide.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450447141-29936-2-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151218 05:57]:
> This avoids the need to add most of the clock aliases under
> drivers/clk/ti/clk-xyz.c files.

Yup is badly needed. Right now we have strange hidden dependencies
in multiple subsystems to enable a single device driver:

1. Add a clock alias for a device
2. Add hwmod entries for a device
3. Add dts entries for a device
4. Add a device driver

We really should only need steps 3 and 4 to do that, hopefully
this takes out #1 on the list above.

Regards,

Tony
