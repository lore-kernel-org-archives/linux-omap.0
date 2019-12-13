From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: Introduce cpuidle for am335x/am437x
Date: Fri, 13 Dec 2019 07:03:44 -0800
Message-ID: <20191213150344.GJ35479@atomide.com>
References: <20191213030755.16096-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191213030755.16096-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [191212 19:07]:
> Hi,
> This series adds support for cpuidle on am335x and am437x using the
> cpuidle_arm driver. When testing on am335x-evm and am437x-gp-evm the
> follow power consumption reductions are seen on v5.5-rc1 baseline:
> 
> 
> Idling at command line, CPUFreq userspace governor to 300MHz:
>   am335x-evm:
>     VDD_MPU: 48 mW -> 5 mW
> 
>   am437x-gp-evm:
>     VDD_MPU: 32 mW -> 3 mW
> 
> 
> Idling at command line, CPUFreq userspace governor to 1GHz:
>   am335x-evm:
>     VDD_MPU: 313 mW -> 18 mW
> 
>   am437x-gp-evm:
>     VDD_MPU: 208 mW -> 10 mW

Hey this is great! A beverage on me when we get a chance :)

For merging, looks like I should take the series after folks are happy
with it. Santosh, care to review and ack if it looks OK?

Regards,

Tony
