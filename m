From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Date: Thu, 11 Apr 2019 09:59:50 -0700
Message-ID: <20190411165950.GR2839@atomide.com>
References: <20190408095239.30378-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408095239.30378-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: s-anna@ti.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [190408 02:53]:
> For non legacy cases, add generic sysc_enable_module()
> and sysc_disable_module() functions.
...

> - Add helper to get best idle mode.
> - Add comment about not preventing clockdomain autoidle
>   during enable/disable.

FYI I have a patch in works to populate clkdm_deny_idle/allow_idle
via platform data functions for ti-sysc driver for non-legacy
cases.

We still need to figure out what we want to do for cases where a
child device driver needs to manage rstctrl reset driver bits not
related for the module reset. Not sure if we need to call
clkdm_deny_idle/allow_idle for those cases too?

Regards,

Tony
