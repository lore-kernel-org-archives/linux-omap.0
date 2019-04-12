From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: dra7: Separate AM57 dtsi files
Date: Fri, 12 Apr 2019 09:57:33 -0700
Message-ID: <20190412165733.GA2839@atomide.com>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190408094249.29894-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408094249.29894-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190408 09:43]:
> AM5 and DRA7 SoC families have different set of modules
> in them so the SoC sepecific dtsi files need to be separated.
> 
> e.g. Some of the major differences between AM576 and DRA76
> 
> 		DRA76x	AM576x
> 
> USB3		x
> USB4		x
> ATL		x
> VCP		x
> MLB		x
> ISS		x
> PRU-ICSS1		x
> PRU-ICSS2		x
> 
> This patch only deals with disabling USB3, USB4 and ATL for
> AM57 variants.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> 
> Changelog:
> 
> v2:
> - fix am57xx-beagle-x15-common.dtsi

Thanks applying this into omap-for-v5.2/dt.

Regards,

Tony
