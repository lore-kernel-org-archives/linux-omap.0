From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
	implementations
Date: Thu, 11 Aug 2011 16:08:07 +0100
Message-ID: <20110811150807.GB4924@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk> <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk> <017101cc581c$6e277530$4a765f90$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43986 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1HKPI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:08:28 -0400
Content-Disposition: inline
In-Reply-To: <017101cc581c$6e277530$4a765f90$%kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, 'Grant Likely' <grant.likely@secretlab.ca>, 'Nicolas Pitre' <nico@fluxnic.net>

On Thu, Aug 11, 2011 at 08:47:18PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> > into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> > and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> > as described in Documentation/gpio.txt
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> on following Samsung stuff...

Thanks.

> As a note, there were duplicated e-mail address Grant and Nicolas in Cc ;)
> I just pushed 'reply all' :)

That's not in the original email, and isn't in any one elses replies....
