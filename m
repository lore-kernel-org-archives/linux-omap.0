From: Sam Protsenko <semen.protsenko@globallogic.com>
Subject: Re: [PATCH] serial: omap: Fix error handling in probe
Date: Thu, 30 Apr 2015 18:38:43 +0300
Message-ID: <CAJOTznWCeF94m-yXOFwSYKzoe7Dq7YM8Vpbstzdw66W92c2MgQ@mail.gmail.com>
References: <1430407733-4762-1-git-send-email-semen.protsenko@globallogic.com>
Reply-To: semen.protsenko@globallogic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430407733-4762-1-git-send-email-semen.protsenko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Grygorii Strashko <grygorii.strashko@linaro.org>, Nishanth Menon <nm@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

v2 of this patch was sent (rebased on top of recent sources).

On Thu, Apr 30, 2015 at 6:28 PM, Semen Protsenko
<semen.protsenko@globallogic.com> wrote:
> There is pm_qos_add_request() being executed on serial_omap_probe(),
> which stores "&up->pm_qos_request" from omap-serial driver to
> "pm_qos_array[PM_QOS_CPU_DMA_LATENCY]->constraints". If
> serial_omap_probe() fails after pm_qos_add_request() (e.g. on
> uart_add_one_port() call), pm_qos_array still keeping pm_qos_request
> struct from omap-serial driver, which is not valid anymore (since driver
> failed). This leads further to kernel crash on pm_qos_update_target(),
> executing from some completely different driver.
>
> We were observing this while trying to run audio playback while having
> one of omap-serial driver instances failed on uart_add_one_port() call:
>     Unable to handle kernel paging request at virtual address fffffffc
>     Backtrace:
>     (plist_add) from (pm_qos_update_target)
>     (pm_qos_update_target) from (pm_qos_add_request)
>     (pm_qos_add_request) from (snd_pcm_hw_params)
>     (snd_pcm_hw_params) from (snd_pcm_common_ioctl1)
>     (snd_pcm_common_ioctl1) from (snd_pcm_playback_ioctl1)
>     (snd_pcm_playback_ioctl1) from (snd_pcm_playback_ioctl)
>     (snd_pcm_playback_ioctl) from (do_vfs_ioctl)
>     (do_vfs_ioctl) from (SyS_ioctl)
>     (SyS_ioctl) from (ret_fast_syscall)
>
> This patch adds pm_qos_remove_request() on fail path in
> serial_omap_probe() in order to fix this issue. While at it, free the
> wakeup settings on fail path as well, just like it's done in
> serial_omap_remove().
>
> Signed-off-by: Semen Protsenko <semen.protsenko@globallogic.com>
> ---
>  drivers/tty/serial/omap-serial.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index d55714d..8d03486 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1761,6 +1761,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>  err_add_port:
>         pm_runtime_put(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +       pm_qos_remove_request(&up->pm_qos_request);
> +       device_init_wakeup(up->dev, false);
>  err_rs485:
>  err_port_line:
>         dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> --
> 1.7.9.5
>
