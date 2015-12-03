From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Change core_initcall levels to
 postcore_initcall
Date: Thu, 3 Dec 2015 08:00:14 -0800
Message-ID: <20151203160014.GL23396@atomide.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
 <1448900789-4034-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1448900789-4034-3-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151130 08:29]:
> We want to be able to probe a few selected device drivers before hwmod
> code populates the clocks in omap_hwmod_setup_all(). This allows us to
> convert most of the clock drivers into regular device drivers.
> 
> We only need a few minimal clock drivers early for the system timers to
> select between the 32KiHz clock and the high frequency oscillator.
> 
> With these changes, initializing the clock drivers can be just done at
> core_initcall time with something like:
> 
> np = of_find_node_by_name(NULL, "plls");
> if (np)
> 	of_platform_populate(np, NULL, NULL, NULL);
> 
> And then these clocks will be available for the interconnect code to use.
> 
> Having most of the clock drivers being regular device drivers allows
> us to use the nice things like devm_* functions and dev_err and dev_dbg.
> As an extra bonus, this also allows us to develop the clock drivers for
> new SoCs as loadable modules initially for cases where we can boot up
> the system based on the bootloader configured clocks.
> 
> To do this, let's change the core_initcalls to postcore_initcall under
> mach-omap2.

FYI I'm applying this one into omap-for-v4.5/soc today, the first patch
in this series needs more work as discussed.

Regards,

Tony
