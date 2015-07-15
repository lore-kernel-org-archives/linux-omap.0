From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7: Provide proper IO map table
Date: Tue, 14 Jul 2015 23:26:17 -0700
Message-ID: <20150715062616.GY17550@atomide.com>
References: <1434985934-29132-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434985934-29132-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150622 08:14]:
> DRA7 uses OMAP5 IO table at the moment. This is purely spurious since
> the OMAP5 and DRA7 register maps are different in many aspects.
> 
> AM57xx/DRA7 TRM Reference: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
> 
> NOTE: Most of the drivers are already doing ioremap, so, there should'nt
> be any functional improvement involved here, other than making the
> initial iotable more accurate.
> 
> Fixes: a3a9384a1157 ("ARM: DRA7: Reuse io tables and add a new .init_early")
> Signed-off-by: Nishanth Menon <nm@ti.com>

Is this needed for v4.2-rc or can this wait for v4.3 merge window?

Regards,

Tony
