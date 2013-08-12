From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: HSI: Introduce OMAP SSI driver
Date: Mon, 12 Aug 2013 01:28:51 -0700
Message-ID: <20130812082851.GK7656@atomide.com>
References: <1376237628-1077-1-git-send-email-sre@debian.org>
 <1376237877-1740-1-git-send-email-sre@debian.org>
 <1376237877-1740-2-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376237877-1740-2-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Sebastian Reichel <sre@ring0.de>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [130811 09:25]:
> From: Sebastian Reichel <sre@ring0.de>
> 
> This patch adds an OMAP SSI driver to the HSI framework.
> 
> The Synchronous Serial Interface (SSI) is a legacy version
> of HSI. As in the case of HSI, it is mainly used to connect
> Application engines (APE) with cellular modem engines (CMT)
> in cellular handsets.
> 
> It provides a multichannel, full-duplex, multi-core communication
> with no reference clock. The OMAP SSI block is capable of reaching
> speeds of 110 Mbit/s.

Good to see this being worked on, maybe we can finally start
making calls with mainline kernel :)

This one should be queued by:

$ scripts/get_maintainer.pl -f drivers/hsi

This should be a stand alone patch, right? You should resend
with those people in cc.

Regards,

Tony
