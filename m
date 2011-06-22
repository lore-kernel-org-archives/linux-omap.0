From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/25 v2] Re-jig cpu_suspend for a saner calling
	convention
Date: Wed, 22 Jun 2011 22:01:47 +0100
Message-ID: <20110622210147.GC9449@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2011 at 04:08:16PM +0100, Russell King - ARM Linux wrote:
> Tested on Assabet (SA1100) and 3430LDP only.

Correction - because suspend only goes into retention mode, these
changes have not been tested on the 3430.  Someone who knows what
they're doing with the mega-complicated OMAPs (and so knows how to
trigger the required modes to test these code paths) needs to test
this.

It will currently fail when trying to call cpu_resume() because we're
trying the virtual address for that function, whereas it needs to be
the physical address.  That's left as an exercise to solve (easiest
way is probably to pass virt_to_phys(cpu_resume) into _omap_sram_idle
and get it to save that away in SRAM.)
