From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
	make 2430 boot again
Date: Thu, 5 Apr 2007 19:12:46 +0530
Message-ID: <5d5443650704050642n2fcebf7dg34b5e94be428de96@mail.gmail.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
	<4614EF05.6050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4614EF05.6050606@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On 4/5/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> >
> good catch.. missed that one.

Nop. You have only made change in wdt_probe, but missed wdt_remove for
setting drvdata to NULL. Please do the same there.

>
>  static int omap_wdt_remove(struct platform_device *pdev)
>  {
> -       struct resource *mem = platform_get_drvdata(pdev);
> -       misc_deregister(&omap_wdt_miscdev);
> -       release_resource(mem);
> -       if (armwdt_ck)
> -               clk_put(armwdt_ck);
> -       if (mpu_wdt_ick)
> -               clk_put(mpu_wdt_ick);
> -       if (mpu_wdt_fck)
> -               clk_put(mpu_wdt_fck);
> +       struct omap_wdt_dev *wdev;
> +       wdev = (struct omap_wdt_dev *) platform_get_drvdata(pdev);
> +
> +       misc_deregister(&(wdev->omap_wdt_miscdev));
> +       release_resource(wdev->mem);
> +       if (wdev->armwdt_ck)
> +               clk_put(wdev->armwdt_ck);
> +       if (wdev->mpu_wdt_ick)
> +               clk_put(wdev->mpu_wdt_ick);
> +       if (wdev->mpu_wdt_fck)
> +               clk_put(wdev->mpu_wdt_fck);
> +       kfree(wdev);
> +       omap_wdt_dev = NULL;
>         return 0;
>  }
>

-- 
--Trilok Soni
