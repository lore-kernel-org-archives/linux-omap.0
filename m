From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest randconfig build errors
Date: Mon, 4 Mar 2013 20:34:43 +0000
Message-ID: <201303042034.43833.arnd@arndb.de>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130304095136.GI17833@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 04 March 2013, Russell King - ARM Linux wrote:

> Versatile randconfig:
> 
> ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-em.ko] undefined!
> 

I'm pretty sure I submitted a patch for this one before. I'll go looking
for it. IIRC the solution was to export that symbol.

	Arnd
