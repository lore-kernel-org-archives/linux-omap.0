From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: Separate AM57 dtsi files
Date: Sat, 6 Apr 2019 15:40:17 +0530
Message-ID: <0e1de55a-7333-7940-6965-8080d9fb0b14@ti.com>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190405132806.20772-3-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405132806.20772-3-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05/04/19 6:58 PM, Roger Quadros wrote:
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

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
