From: "Hilman, Kevin" <khilman@ti.com>
Subject: Re: [PATCH] drivers/rtc/rtc-twl.c: fix threaded IRQ to use IRQF_ONESHOT
Date: Fri, 6 Jul 2012 07:25:32 -0700
Message-ID: <CALyTGOCYJX1St+0XsGujovOn-xFmBVFNpFRzzM9KrL-0qcObqg@mail.gmail.com>
References: <1340900265-11962-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:53978 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756338Ab2GFO03 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 10:26:29 -0400
Received: by qcsu28 with SMTP id u28so6347305qcs.8
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 07:25:32 -0700 (PDT)
In-Reply-To: <1340900265-11962-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org

Alessandro,

Gentle reminder ping on this one so it can make it in for v3.5-rc.   Thanks.

On Thu, Jun 28, 2012 at 9:17 AM, Kevin Hilman <khilman@ti.com> wrote:
> Requesting a threaded interrupt without a primary handler and without
> IRQF_ONESHOT is dangerous, and after commit 1c6c6952 (genirq: Reject
> bogus threaded irq requests), these requests are rejected.  This
> causes ->probe() to fail, and the RTC driver not to be availble.
>
> To fix, add IRQF_ONESHOT to the IRQ flags.
>
> Tested on OMAP3730/OveroSTORM and OMAP4430/Panda board using rtcwake
> to wake from system suspend multiple times.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> This fix is needed in v3.5.
> Applies on top of v3.5-rc4.
>
>  drivers/rtc/rtc-twl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index 258abea..c5d06fe 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -510,7 +510,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
>         }
>
>         ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
> -                                  IRQF_TRIGGER_RISING,
> +                                  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>                                    dev_name(&rtc->dev), rtc);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "IRQ is not free.\n");
> --
> 1.7.9.2
>
