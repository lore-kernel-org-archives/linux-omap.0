From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias()
 prototype in linux/clk.h
Date: Fri, 3 Apr 2015 16:49:18 -0700
Message-ID: <20150403234918.GD18048@atomide.com>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [150403 10:13]:
> clk_add_alias() is provided by clkdev, and is not part of the clk API.
> Howver, it is prototyped in two locations: linux/clkdev.h and
> linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
> version in linux/clk.h.

Acked-by: Tony Lindgren <tony@atomide.com>
