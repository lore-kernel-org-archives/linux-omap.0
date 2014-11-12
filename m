From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv6 5/5] hwspinlock/omap: add support for dt nodes
Date: Wed, 12 Nov 2014 21:14:44 +0200
Message-ID: <CAK=WgbZE7_WrsNz5E+MDX7j2tAGEjv91zeCgqhB=Jsiu0+d8vw@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-6-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410553499-55951-6-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
>  static int omap_hwspinlock_probe(struct platform_device *pdev)
>  {
> -       struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
> +       struct device_node *node = pdev->dev.of_node;
>         struct hwspinlock_device *bank;
>         struct hwspinlock *hwlock;
>         struct resource *res;
>         void __iomem *io_base;
> -       int num_locks, i, ret;
> +       int num_locks, i, ret, base_id;
>
> -       if (!pdata)
> +       if (!node)
>                 return -ENODEV;
>
> +       ret = of_hwspin_lock_get_base_id(node);
> +       if (ret < 0 && ret != -EINVAL)
> +               return -ENODEV;
> +       base_id = (ret > 0 ? ret : 0);

Does this mean you allow nodes not to have the base_id property? How
do we protect against multiple nodes not having a base_id property
then?

Implicitly assuming a base_id value (zero in this case) may not be always safe.

Thanks,
Ohad.
