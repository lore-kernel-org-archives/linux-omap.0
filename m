From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] memory: omap-gpmc: Add support for AAD timings
Date: Wed, 27 Jan 2016 10:58:16 -0800
Message-ID: <20160127185815.GW19432@atomide.com>
References: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
 <1451309961-7247-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451309961-7247-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [151228 05:39]:
> In order to support extended timings parameters on hardware supporting the
> "AAD" mode like the AM335x or DM816x, add these entries into the GPMC driver
> if the hardware is capable.
> 
> Tested on DM816x and AM335x.

Both look OK to me, assuming Roger will queue these:

Acked-by: Tony Lindgren <tony@atomide.com>
