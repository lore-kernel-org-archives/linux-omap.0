From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Wed, 13 Apr 2016 12:31:12 -0700
Message-ID: <20160413193112.GX5995@atomide.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
 <570D25EB.1010709@oracle.com>
 <570D39FB.8050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570D39FB.8050006@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160412 11:11]:
> On 04/12/2016 07:44 PM, santosh shilimkar wrote:
> I expect no issues (only if some platforms expect to wake up from
> gpio irq, but do not configure this irq as wakeup irq).
> ^ and this will be a bug which need to be fixed.

This seems like a safe assumption to me.

Regards,

Tony
