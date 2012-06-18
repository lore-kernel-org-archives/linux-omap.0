From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
Date: Mon, 18 Jun 2012 11:11:13 +0530
Message-ID: <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:36886 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab2FRFle convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 01:41:34 -0400
Received: by qcsd16 with SMTP id d16so3124869qcs.0
        for <linux-omap@vger.kernel.org>; Sun, 17 Jun 2012 22:41:33 -0700 (PDT)
In-Reply-To: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-omap <linux-omap@vger.kernel.org>

(You should cc linux-omap too.  CC'ing linux-omap)

On Mon, Jun 18, 2012 at 10:53 AM, Lokesh Vutla <lokeshvutla@ti.com> wro=
te:
> OMAP watchdong driver is adapted to runtime PM like a general device
> driver but it is not appropriate. It is causing couple of functional
> issues.
>
> 1. On OMAP4 SYSCLK can't be gated, because of issue with WDTIMER2 mod=
ule,
> which constantly stays in "in transition" state. Value of register
> CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.
> Issue occurs immediately after first idle, when hwmod framework tries
> to disable WDTIMER2 functional clock - "wd_timer2_fck". After this
> module falls to "in transition" state, and SYSCLK gating is blocked.
>
> 2. Due to runtime PM, watchdog timer may be completely disabled.
> In current code base watchdog timer is not disabled only because of
> issue 1. Otherwise state of WDTIMER2 module will be "Disabled", and t=
here
> will be no interrupts from omap_wdt. In other words watchdog will not
> work at all.
>
> Watchdong is a special IP and it should not be disabled otherwise
> purpose of it itself is defeated. Watchdog functional clock should
> never be disabled. This patch updates the runtime PM handling in
> driver so that runtime PM is limited only during probe/shutdown
> and suspend/resume.
>
> The patch fixes issue 1 and 2
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> Tested on OMAP4430SDP.
>
> Issue #1 can be easily reproduced on mainline kernel.
> - Take latest mainline kernel and create uImage using omap2plus_defco=
nfig
> - Write a program to open watchdog,like
> void main(void)
> {
> =A0 =A0 =A0 =A0int fd =3D open("/dev/watchdog", O_WRONLY);
>
> =A0 =A0 =A0 =A0if (fd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("Watchdog device interface is n=
ot available!\n");
> =A0 =A0 =A0 =A0}
> }
> - Build with arm compiler and copy it to your file syatem
> - Boot the image and run the executable.
>
>
> =A0drivers/watchdog/omap_wdt.c | =A0 17 -----------------
> =A01 files changed, 0 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.=
c
> index 8285d65..27ab8db 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -126,8 +126,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_=
dev *wdev)
> =A0 =A0 =A0 =A0u32 pre_margin =3D GET_WLDR_VAL(timer_margin);
> =A0 =A0 =A0 =A0void __iomem *base =3D wdev->base;
>
> - =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> -
> =A0 =A0 =A0 =A0/* just count up at 32 KHz */
> =A0 =A0 =A0 =A0while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> @@ -135,8 +133,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_=
dev *wdev)
> =A0 =A0 =A0 =A0__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
> =A0 =A0 =A0 =A0while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> -
> - =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> =A0}
>
> =A0/*
> @@ -166,8 +162,6 @@ static int omap_wdt_open(struct inode *inode, str=
uct file *file)
> =A0 =A0 =A0 =A0omap_wdt_ping(wdev); /* trigger loading of new timeout=
 value */
> =A0 =A0 =A0 =A0omap_wdt_enable(wdev);
>
> - =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> -
> =A0 =A0 =A0 =A0return nonseekable_open(inode, file);
> =A0}
>
> @@ -179,8 +173,6 @@ static int omap_wdt_release(struct inode *inode, =
struct file *file)
> =A0 =A0 =A0 =A0 * =A0 =A0 =A0Shut off the timer unless NOWAYOUT is de=
fined.
> =A0 =A0 =A0 =A0 */
> =A0#ifndef CONFIG_WATCHDOG_NOWAYOUT
> - =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> -
> =A0 =A0 =A0 =A0omap_wdt_disable(wdev);
>
> =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev->dev);
> @@ -199,11 +191,9 @@ static ssize_t omap_wdt_write(struct file *file,=
 const char __user *data,
>
> =A0 =A0 =A0 =A0/* Refresh LOAD_TIME. */
> =A0 =A0 =A0 =A0if (len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&wdt_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&wdt_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return len;
> =A0}
> @@ -236,18 +226,15 @@ static long omap_wdt_ioctl(struct file *file, u=
nsigned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(int __user *)arg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return put_user(0, (int __user *)arg);
> =A0 =A0 =A0 =A0case WDIOC_KEEPALIVE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&wdt_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&wdt_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0case WDIOC_SETTIMEOUT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (get_user(new_margin, (int __user *=
)arg))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_adjust_timeout(new_margin);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&wdt_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_set_timeout(wdev);
> @@ -255,7 +242,6 @@ static long omap_wdt_ioctl(struct file *file, uns=
igned int cmd,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&wdt_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fall */
> =A0 =A0 =A0 =A0case WDIOC_GETTIMEOUT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return put_user(timer_margin, (int __u=
ser *)arg);
> @@ -363,7 +349,6 @@ static void omap_wdt_shutdown(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0struct omap_wdt_dev *wdev =3D platform_get_drvdata(pde=
v);
>
> =A0 =A0 =A0 =A0if (wdev->omap_wdt_users) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0}
> @@ -403,7 +388,6 @@ static int omap_wdt_suspend(struct platform_devic=
e *pdev, pm_message_t state)
> =A0 =A0 =A0 =A0struct omap_wdt_dev *wdev =3D platform_get_drvdata(pde=
v);
>
> =A0 =A0 =A0 =A0if (wdev->omap_wdt_users) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0}
> @@ -419,7 +403,6 @@ static int omap_wdt_resume(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(wdev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_enable(wdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev->dev);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
