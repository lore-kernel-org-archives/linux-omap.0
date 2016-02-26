From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Fri, 26 Feb 2016 11:18:48 -0800
Message-ID: <20160226191848.GJ13417@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-6-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456439796-28546-6-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: paul@pwsan.com, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
> From: Vignesh R <vigneshr@ti.com>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.

Are the dts changes safe to pick separately? I'm mostly worried
about clock related hangs unless the clock changes are merged
first.

Regards,

Tony
