From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/5] arm: dts: am57xx-idk-common: Add overide
 powerhold property
Date: Mon, 14 Nov 2016 16:09:19 -0800
Message-ID: <20161115000918.GE4082@atomide.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478754560-27923-6-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [161109 21:10]:
> The PMICs have POWERHOLD set by default which prevents PMIC shutdown
> even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
> So to enable pmic power off this property lets one over ride the default
> value and enable pmic power off.

This too:

Acked-by: Tony Lindgren <tony@atomide.com>
