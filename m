From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-sdp: add dynamic pin states for
 uart3/4
Date: Thu, 18 Jul 2013 02:04:08 -0700
Message-ID: <20130718090408.GU7656@atomide.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-4-git-send-email-grygorii.strashko@ti.com>
 <20130717153248.GI7656@atomide.com>
 <51E6C939.40208@ti.com>
 <20130718080953.GR7656@atomide.com>
 <51E7AD38.6010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51E7AD38.6010108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <benoit.cousson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130718 02:01]:
> On 07/18/2013 11:09 AM, Tony Lindgren wrote:
> 
> Don't think it's debug code - IO chain need to be rearmed after each
> PRCM IO IRQ - otherwise IO wakeup events may be lost (at least on
> OMAP4, OMAP5 requires more complex handling(( ).

Nope, only after the mux register changes. I've verified it on
am3730 with off-idle for both serial and wl12xx.
 
> I didn't pick up your padconf patches yet -seems i need to be in sync :)

Well you need those for proper wake-up event support..

> Below the diff I used to verify IO wake up (It follows old IO daisy
> chain hanlding models in hwmod before DT):

..then these changes not needed with the pinctrl-single changes.

Regards,

Tony
