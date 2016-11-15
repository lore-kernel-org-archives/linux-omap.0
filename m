From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] Documentation: pinctrl: palmas: Add
 ti,palmas-powerhold-override property definition
Date: Mon, 14 Nov 2016 19:43:52 -0600
Message-ID: <20161115014352.5d3qwoonlo63mp5p@rob-hp-laptop>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478754560-27923-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2016 at 10:39:16AM +0530, Keerthy wrote:
> GPIO7 is configured in POWERHOLD mode which has higher priority
> over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> bit is turned off. This property enables driver to over ride the
> POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> scenarios.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
