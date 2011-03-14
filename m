From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/5] OMAP2+:Common CPU DIE ID reading code reads
 wrong registers for OMAP4430
Date: Mon, 14 Mar 2011 11:12:08 -0700
Message-ID: <20110314181207.GD7258@atomide.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
 <20110312225054.27728.89155.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110312225054.27728.89155.stgit@otae.warmcat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Green <andy.green@linaro.org>, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

* Andy Green <andy@warmcat.com> [110312 14:49]:
> This adapts the register offsets used to read the CPU DIE ID registers
> when run on 44XX so they match what is in the OMAP4430 Reference Manual
> page 269

I'll apply only this patch, looks like the rest needs more discussion.

Regards,

Tony
