From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: TI816X: add powerdomains for TI816x
Date: Tue, 18 Jun 2013 01:31:39 -0700
Message-ID: <20130618083139.GF5523@atomide.com>
References: <1369926290-30404-1-git-send-email-aida.mynzhasova@skitlab.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369926290-30404-1-git-send-email-aida.mynzhasova@skitlab.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aida Mynzhasova <aida.mynzhasova@skitlab.ru> [130530 08:10]:
> This patch adds required structures for powerdomain initialization on
> the ti816x. It is impossible to use omap3430 structures in order to
> initialize powerdomains on ti816x, because there are big differences
> between PRCM module base address offsets on these CPUs.

Thanks this looks safe for me to apply so applying to omap-for-v3.11/soc.

Regards,

Tony
