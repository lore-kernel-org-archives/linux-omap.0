From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Sat, 7 Sep 2013 09:57:13 +0100
Message-ID: <20130907085713.GJ25647@n2100.arm.linux.org.uk>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com> <52278F84.2080509@elopez.com.ar> <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com> <20130906111408.GI25647@n2100.arm.linux.org.uk> <20130906164059.GC3558@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53755 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3IGI5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Sep 2013 04:57:41 -0400
Content-Disposition: inline
In-Reply-To: <20130906164059.GC3558@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russ Dill <Russ.Dill@ti.com>, "mans@mansr.com" <mans@mansr.com>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 06, 2013 at 05:40:59PM +0100, Dave Martin wrote:
> I actually wonder whether fncpy() contains a buglet, whereby
> flush_icache_range() is used instead of coherent_kern_range().
> The SRAM is probably not mapped cached, but at least a DSB would be
> needed before flushing the relevant lines from the I-cache.

flush_icache_range() is correct - it's there to ensure that memory which
has been written will be readable to the instruction stream.  That's it's
whole purpose, and it's used when modules are loaded too.

You're reading too much into the name: it doesn't just touch the I cache.
