From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap mmc: extended to pass host capabilities from
 board file
Date: Thu, 23 Sep 2010 16:08:20 -0700
Message-ID: <20100923230819.GS4211@atomide.com>
References: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sukumar Ghorai <s-ghorai@ti.com> [100915 07:41]:
>   wires variable is renamed, extended and this single variable to be used to
>   pass the platform capabilities, e.g DDR mode. Also removed the hardcoded
>   value was using as bus-width.

This looks like a nice clean-up, I'll queue this via the omap
patches.

Regards,

Tony
