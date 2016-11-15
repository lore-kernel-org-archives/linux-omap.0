From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Mon, 14 Nov 2016 16:08:49 -0800
Message-ID: <20161115000849.GD4082@atomide.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [161109 21:10]:
> The PMICs have POWERHOLD set by default which prevents PMIC shutdown
> even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
> So to enable pmic power off this property lets one over ride the default
> value and enable pmic power off.

This should not cause merge conflicts so probably best to merge along
with the driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>

If you guys want me to pick up this separately let me know.

Regards,

Tony
