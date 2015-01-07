From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arch: arm: mach-omap2: omap_hwmod.c:  Remove some unused
 functions
Date: Wed, 7 Jan 2015 09:16:26 -0800
Message-ID: <20150107171626.GA13010@atomide.com>
References: <1417973047-12972-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417973047-12972-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se> [141207 09:23]:
> Removes some functions that are not used anywhere:
> omap_hwmod_pad_route_irq() omap_hwmod_no_setup_reset()
> omap_hwmod_read_hardreset() omap_hwmod_del_initiator_dep()
> omap_hwmod_enable_clocks() omap_hwmod_reset() omap_hwmod_ocp_barrier()
> omap_hwmod_disable_clocks() omap_hwmod_add_initiator_dep()
> 
> This was partially found by using a static code analysis program called cppcheck.

Nice, we should probably run cppcheck for unused functions on
regular basis as we're slowly removing the legacy booting
support in favor of device tree based booting.

Paul, I'm applying all your arch/arm/*omap*/ cppcheck patches
into omap-for-v3.20/cleanup branch that can then be used as a
base for other branches in case of conflicts.

Richard, I've also unified the subject lines to start with
ARM: OMAP2+: and so on to make my pull requests will look
a bit nicer.

Regards,

Tony
