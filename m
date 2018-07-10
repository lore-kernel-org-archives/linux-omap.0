From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: sleep33/43xx: Make sleep actions
 configurable
Date: Mon, 9 Jul 2018 23:17:43 -0700
Message-ID: <20180710061743.GH99251@atomide.com>
References: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180709 00:36]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add an argument to the sleep33xx and sleep43xx code to allow us to set
> flags to determine which portions of the code get called in order to use
> the same code for multiple power saving modes. This patch allows us to
> decide whether or not we flush and disable caches, save EMIF context,
> put the memory into self refresh and disable the EMIF, and/or invoke
> the wkup_m3 when entering into WFI.

Thanks applying both into omap-for-v4.19/soc.

Tony
