From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V4 00/16] irqchip: crossbar: Driver fixes
Date: Tue, 1 Jul 2014 00:59:30 -0700
Message-ID: <20140701075930.GN28884@atomide.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <20140630192910.GA23978@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140630192910.GA23978@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, linux@arm.linux.org.uk, rnayak@ti.com, santosh.shilimkar@ti.com, joe@perches.com, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

* Jason Cooper <jason@lakedaemon.net> [140630 12:30]:
> 
> Whole series applied to irqchip/crossbar, I'll give it a day or two in
> -next, then I'll merge it into irqchip/core.
> 
> Tony: Right now, it's immutable unless you tell me I applied something
> incorrectly.  Once it goes into irqchip/core, it's immutable no matter
> what you say. ;-)

Thanks, looks good to me. Sricharan and Nishant, can you please
check that we can now apply the related .dts changes on top of
Jason's branch at:

git://git.infradead.org/users/jcooper/linux.git irqchip/crossbar

Regards,

Tony
