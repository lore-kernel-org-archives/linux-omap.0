From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for
 tps65218
Date: Fri, 17 Jun 2016 02:59:26 -0700
Message-ID: <20160617095925.GD22406@atomide.com>
References: <1465971328-16046-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465971328-16046-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, d-gerlach@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Aparna Balasubramanian <aparnab@ti.com>
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [160614 23:18]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Based on the latest timing specifications for the TPS65218 from the data
> sheet, http://www.ti.com/lit/ds/symlink/tps65218.pdf, document SLDS206
> from November 2014, we must change the i2c bus speed to better fit within
> the minimum high SCL time required for proper i2c transfer.
> 
> When running at 400khz, measurements show that SCL spends
> 0.8125 uS/1.666 uS high/low which violates the requirement for minimum
> high period of SCL provided in datasheet Table 7.6 which is 1 uS.
> Switching to 100khz gives us 5 uS/5 uS high/low which both fall above
> the minimum given values for 100 khz, 4.0 uS/4.7 uS high/low.
> 
> Without this patch occasionally a voltage set operation from the kernel
> will appear to have worked but the actual voltage reflected on the PMIC
> will not have updated, causing problems especially with cpufreq that may
> update to a higher OPP without actually raising the voltage on DCDC2,
> leading to a hang.

Applying into omap-for-v4.7/fixes thanks.

Tony
