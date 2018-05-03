From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap1: ams-delta: fix deferred_fiq handler
Date: Thu, 3 May 2018 10:08:20 -0700
Message-ID: <20180503170820.GW98604@atomide.com>
References: <20180502183203.16034-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502183203.16034-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180502 11:34]:
> The deferred_fiq handler used to limit hardware operations to IRQ
> unmask only, relying on gpio-omap assigned handler performing the ACKs.
> Since commit 80ac93c27441 ("gpio: omap: Fix lost edge interrupts") this
> is no longer the case as handle_edge_irq() has been replaced with
> handle_simmple_irq() which doesn't touch the hardware.
> 
> Add single ACK operation per each active IRQ pin to the handler. While
> being at it, move unmask operation out of irq_counter loop so it is
> also called only once for each active IRQ pin.

Good to hear the fiq handler is confirmed working, applying
into omap-for-v4.17/fixes thanks.

Tony
