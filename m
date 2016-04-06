From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] arm: omap2: remove redundant multiplatform checks
Date: Wed, 6 Apr 2016 12:14:34 -0700
Message-ID: <20160406191433.GF16484@atomide.com>
References: <201604060526.ouhQYqrT%fengguang.wu@intel.com>
 <1459895738-6546-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
 <5704CC9F.6010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5704CC9F.6010502@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Jonas Rabenstein <ve92mose@stud.informatik.uni-erlangen.de>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [160406 01:50]:
> +Tony
> 
> On Wednesday 06 April 2016 01:44 PM, Jonas Rabenstein wrote:
> > From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > 
> > The directory arch/arm/mach-omap2 is only selected for compilation if
> > CONFIG_ARCH_OMAP2PLUS is selected. CONFIG_ARCH_OMAP2PLUS itself is a
> > silent option and all machines selecting this option are multiplatform
> > devices. As a consequence checks for CONFIG_ARCH_MULTIPLATFORM as well
> > as CONFIG_ARCH_OMAP2PLUS within that directory are superfluous and can
> > be removed.
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Yeah nice if we can remove the legacy multi SoC options. I'll take
a closer look within few days as I'm still at ELC.

Regards,

Tony
