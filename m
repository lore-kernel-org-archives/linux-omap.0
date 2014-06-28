From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] drivers/power/avs/smartreflex.c: remove unnecessary
 null test before debugfs_remove_recursive
Date: Sat, 28 Jun 2014 08:36:23 -0500
Message-ID: <53AEC4D7.50205@ti.com>
References: <1403958799-4692-1-git-send-email-fabf@skynet.be>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403958799-4692-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Minor fix of $subject to be inline with existing logs needed.
PM / AVS: SmartReflex: ..

On 06/28/2014 07:33 AM, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>   drivers/power/avs/smartreflex.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index db9973b..ecc5979 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -1001,8 +1001,7 @@ static int omap_sr_remove(struct platform_device *pdev)
>
>   	if (sr_info->autocomp_active)
>   		sr_stop_vddautocomp(sr_info);
> -	if (sr_info->dbg_dir)
> -		debugfs_remove_recursive(sr_info->dbg_dir);
> +	debugfs_remove_recursive(sr_info->dbg_dir);
>
>   	pm_runtime_disable(&pdev->dev);
>   	list_del(&sr_info->node);
>
Acked-by: Nishanth Menon <nm@ti.com>
