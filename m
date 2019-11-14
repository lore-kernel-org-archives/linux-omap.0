From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: dra7-atl: Remove pm_runtime_irq_safe()
Date: Thu, 14 Nov 2019 08:50:58 -0800
Message-ID: <20191114165058.GQ5610@atomide.com>
References: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191114 10:16]:
> This is not needed for anything, and prevents proper PM transitions for
> parent devices which is bad in case of ti-sysc; this effectively kills
> PM completely. Thus, remove the flag.

Good to hear and thanks for clearing this one:

Reviewed-by: Tony Lindgren <tony@atomide.com>
