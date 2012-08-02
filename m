From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: hwmod: revise deassert sequence
Date: Thu, 2 Aug 2012 01:52:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208020150240.4177@utopia.booyaka.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org> <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello OMar,

On Mon, 16 Jul 2012, Omar Ramirez Luna wrote:

> For a reset sequence to complete cleanly, a module needs its
> associated clocks to be enabled, otherwise the timeout check
> in prcm code can print a false failure (failed to hardreset)
> that occurs because the clocks aren't powered ON and the status
> bit checked can't transition without them.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Is enabling the clocks sufficient?  Or do we also need to enable the 
IP block, e.g. by calling

	if (soc_ops.enable_module)
		soc_ops.enable_module(oh);

as we do on OMAP4+ in _enable() ?


- Paul
