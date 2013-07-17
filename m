From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] pinctrl: rollback check for !dev->pins in
 pinctrl_pm_select*() APIs
Date: Wed, 17 Jul 2013 08:40:39 -0700
Message-ID: <20130717154038.GK7656@atomide.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374061312-25469-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130717 04:49]:
> The pinctrl support in Device core assumed to be optional - so, It's
> valid case, when there are no definition for default device's pinctrl
> states in DT at all ("default", "active", "idle", "sleep").
> And in this case dev->pins == NULL and pinctrl_pm_select*() API
> should return 0 always.
> 
> Now the checks for !dev->pins have been removed from
> pinctrl_pm_select*() API mistakenly by the patch
> pinctrl: Remove duplicate code in pinctrl_pm_select_state functions
> http://www.spinics.net/lists/arm-kernel/msg258829.html
> 
> Hence, rollback these checks in in pinctrl_pm_select*() APIs.

Thanks, it's best that I fold this fix into my patch as it has not
been committed yet.

Regards,

Tony
