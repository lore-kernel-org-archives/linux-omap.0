From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/17] ARM: OMAP2+: use pdata quirks for PRUSS reset
 lines on AM335x
Date: Fri, 23 Nov 2018 08:40:08 -0800
Message-ID: <20181123164008.GD53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542886753-17625-15-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:40]:
> From: Suman Anna <s-anna@ti.com>
> 
> The omap_device API is needed to perform the reset management for
> any IP instances with PRCM RSTCTRL registers (hard reset lines).
> This API is limited to the mach-omap2 layer, and cannot be exposed
> to drivers layer directly. So use platform data ops and pdata quirks
> for the PRUSS IP in AM335x SoCs to plumb the required omap_device
> API. The PRUSS SoC bus driver can then use these pdata ops to
> achieve the required reset functionality.
> 
> This is being implemented this way as there is no separate reset
> driver at the moment.

If the reset-simple approach has issues we can certainly do
this until the issues are fixed. I believe Suman had an issue
where we need to prevent the related clockdomain from idling.

Regards,

Tony
