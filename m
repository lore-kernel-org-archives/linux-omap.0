From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
Date: Fri, 16 Sep 2016 10:37:59 -0500
Message-ID: <20160916153759.GA12050@rob-hp-laptop>
References: <20160908105203.8641-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160908105203.8641-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 08, 2016 at 12:52:03PM +0200, Marcin Niestroj wrote:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup and set it's polarity, depending on board
> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> notify about power-button presses. Handling power-button presses enables
> to recover from RTC-only power states correctly.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> ---
> Hi,
> 
> This patch adds support for ext_wakeup using generic pinconf device-tree
> bindings, with one added custom property.
> 
> Changes v4 -> v5 (suggested by Rob):
>  * Don't use GPIO defines in ti,input-polarity, use optional ti,active-high
>    boolean instead.
>  * Use '-' instead of '_' in node name.
> 
> Changes v1 -> v4:
>  * This is a total reimplementation, so it is not based on any of the previous
>    patch versions. This approach has been suggested by Tony and Grygorii
>    in [1].
> 
> Patch was developed on 4.7, rebased on 4.8-rc5, tested using chiliBoard.
> 
> [1] http://www.spinics.net/lists/devicetree/msg131516.html
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  21 +++

For the binding:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/rtc/Kconfig                                |   1 +
>  drivers/rtc/rtc-omap.c                             | 168 ++++++++++++++++++++-
>  3 files changed, 182 insertions(+), 8 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
