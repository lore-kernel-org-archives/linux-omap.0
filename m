From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: omap2plus_defconfig: Fix missing video
Date: Fri, 6 Sep 2019 09:17:42 -0700
Message-ID: <20190906161742.GE52127@atomide.com>
References: <20190828183351.822-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190828183351.822-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [190828 11:34]:
> When the panel-dpi driver was removed, the simple-panels driver
> was never enabled, so anyone who used the panel-dpi driver lost
> video, and those who used it inconjunction with simple-panels
> would have to manually enable CONFIG_DRM_PANEL_SIMPLE.
> 
> This patch makes CONFIG_DRM_PANEL_SIMPLE a module in the same
> way the deprecated panel-dpi was.
> 
> Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Applying all three into fixes. Not going to send out a pull
request for the fixes until next week so it may not land
until after the merge window starts. But looks like these
have been broken since 2018, so not super urgent.

Regards,

Tony
