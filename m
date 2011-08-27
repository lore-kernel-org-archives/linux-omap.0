From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 20:33:50 +0530
Message-ID: <4E590756.9030307@ti.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ming.lei@canonical.com
Cc: greg@kroah.com, linux-omap@vger.kernel.org, stern@rowland.harvard.edu, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Saturday 27 August 2011 08:18 PM, ming.lei@canonical.com wrote:
> From: Ming Lei<ming.lei@canonical.com>
>
> This patch fixs one performance bug on ARM Cortex A9 dual core platform,
> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, snowball...),
> see details from link of https://bugs.launchpad.net/bugs/709245.
>
> In fact, one mb() on ARM is enough to flush L2 cache, but
> 'dummy->hw_token = token;' after mb() is added just for obeying
> correct mb() usage.
>
Who said "one mb() on ARM is enough to flush L2 cache" ?
It's just a memory barrier and it doesn't flush any cache.
What it cleans is the CPU write buffers and the L2 cache
write buffers.

> The patch has been tested ok on OMAP4 panda A1 board, the performance
> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
> 14~16MB/sec after applying this patch.
>
Though number looks great, how is the below patch helping to get better
numbers.

> Signed-off-by: Ming Lei<ming.lei@canonical.com>
> ---
>   drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 0917e3a..65b5021 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>   			wmb ();
>   			dummy->hw_token = token;
>
> +			/* The mb() below is added to make sure that
> +			 * 'token' can be writen into qtd, so that ehci
> +			 * HC can see the up-to-date qtd descriptor. On
> +			 * some archs(at least on ARM Cortex A9 dual core),
> +			 * writing into coherenet memory doesn't mean the
> +			 * value written can reach physical memory
> +			 * immediately, and the value may be buffered
> +			 * inside L2 cache. 'dummy->hw_token = token;'
> +			 * after mb() is added for obeying correct mb()
> +			 * usage.
> +			 * */
> +			mb();
> +			token = dummy->hw_token;
> +

This patch at max fix some corruption if the memory buffer
used is buffer-able. Infact I see there is already a write memory
barrier above. So just pushing that down by one line should
be enough.

 >   			dummy->hw_token = token;
 >   			wmb ();

Is there another patch along with this which removes, some cache clean
on this buffer ?

Regards
Santosh
