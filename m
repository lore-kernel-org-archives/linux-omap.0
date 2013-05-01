From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/2] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed, 1 May 2013 16:54:08 -0700
Message-ID: <20130501235407.GO28721@atomide.com>
References: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
 <1367434947-6442-2-git-send-email-Russ.Dill@ti.com>
 <20130501232649.GN28721@atomide.com>
 <CA+Bv8XYGa0c9+6DawMerDUnZnD_0fEESJZeQLDG6MuJrLPYV0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61195 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab3EAXyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 19:54:12 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XYGa0c9+6DawMerDUnZnD_0fEESJZeQLDG6MuJrLPYV0Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

* Russ Dill <Russ.Dill@ti.com> [130501 16:43]:
> On Wed, May 1, 2013 at 4:26 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Looks like you should make that into just a regular device driver that lives
> > under drivers/ somewhere?
> 
> This code has to be copied to, and run from SRAM. What would that even
> look like? Additionally, there is also code under drivers/ that
> manages this piece of hardware, i2c-omap.c. The code in this patch
> differs in that it accesses no system memory, no stack, only knows how
> to write, and it runs without interrupts.

Well we should move to using the generic drivers/misc/sram.c, so
you should be able to load the code to SRAM using that. Then you
can probably register some callback function based on the compatible
flag with i2c-omap.c?

Regards,

Tony
