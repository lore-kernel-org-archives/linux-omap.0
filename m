From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Wed, 14 Nov 2012 11:54:24 +0200
Message-ID: <CAK=WgbZm+sjavwb_Li_W5ygm0XuS9YMYfQEkdoB188Uir0arGg@mail.gmail.com>
References: <1352860489-19960-1-git-send-email-omar.luna@linaro.org>
	<1352860489-19960-3-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1352860489-19960-3-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Omar,

On Wed, Nov 14, 2012 at 4:34 AM, Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations and sysconfig
> handling.
>
> Dues to reset sequence, pm_runtime_put_sync must be used, to avoid
> possible operations with the module under reset.

There are some changes here that might not be trivial to understand in
hindsight; any chance you can add more explanations (even only in the
commit log) regarding:

> @@ -160,11 +160,10 @@ static int iommu_enable(struct omap_iommu *obj)
...
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);
>
>         err = arch_iommu->enable(obj);
>
> -       clk_disable(obj->clk);
>         return err;
>  }

Why do we remove clk_disable here (instead of replacing it with a _put
variant) ?

> @@ -306,7 +303,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>         if (!obj || !obj->nr_tlb_entries || !e)
>                 return -EINVAL;
>
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);

If iommu_enable no longer disables obj->clk before returning, do we
really need to call ->get here (and in all the other similar
instances) ?

> @@ -816,9 +813,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>         if (!obj->refcount)
>                 return IRQ_NONE;
>
> -       clk_enable(obj->clk);
>         errs = iommu_report_fault(obj, &da);
> -       clk_disable(obj->clk);

Why do we remove the clk_ invocations here (instead of replacing them
with get/put variants) ?

Most of the above questions imply this patch not only converts the
iommu to runtime PM, but may carry additional changes that may imply
previous implementation is sub-optimal. I hope we can clearly document
the motivation behind these changes too (maybe even consider
extracting them to a different patch ?).

> @@ -990,6 +981,9 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
>                 goto err_irq;
>         platform_set_drvdata(pdev, obj);
>
> +       pm_runtime_irq_safe(obj->dev);

Let's also document why _irq_safe is needed here ?

Thanks,
Ohad.
