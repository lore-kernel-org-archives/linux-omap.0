From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Fri, 17 Feb 2012 10:47:58 +0000
Message-ID: <20120217104758.GO15338@n2100.arm.linux.org.uk>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com> <0401fed02a58f7bc48cc274050adbac7@localhost> <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55086 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2BQKsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 05:48:35 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Fri, Feb 17, 2012 at 04:10:57PM +0530, Shilimkar, Santosh wrote:
> -	if (!IS_ERR(twd_clk))
> +	if ((!twd_evt) && (!__this_cpu_ptr(twd_evt)) && (!IS_ERR(twd_clk)))

Too many parens.
