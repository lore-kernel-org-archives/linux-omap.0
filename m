From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 12:15:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108301213250.2109-100000@iolanthe.rowland.org>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <ming.lei@canonical.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2011 ming.lei@canonical.com wrote:

> From: Ming Lei <ming.lei@canonical.com>
> 
> This patch introduces the helper of ehci_sync_mem to flush
> qtd/qh into memory immediately on some ARM, so that HC can
> see the up-to-date qtd/qh descriptor asap.
> 
> This patch fixs one performance bug on ARM Cortex A9 dual core
> platform, which has been reported on quite a few ARM machines
> (OMAP4, Tegra 2, snowball...), see details from link of
> https://bugs.launchpad.net/bugs/709245.
> 
> The patch has been tested ok on OMAP4 panda A1 board, and the
> performance of 'dd' over usb mass storage can be increased from
> 4~5MB/sec to 14~16MB/sec after applying this patch.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  drivers/usb/host/ehci-q.c |   18 ++++++++++++++++++
>  drivers/usb/host/ehci.h   |   17 +++++++++++++++++
>  2 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 0917e3a..2719879 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -995,6 +995,12 @@ static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
>  	head->qh_next.qh = qh;
>  	head->hw->hw_next = dma;
>  
> +	/*
> +	 * flush qh descriptor into memory immediately,
> +	 * see comments in qh_append_tds.
> +	 * */

Comments are supposed to look like this:

	/*
	 * Blah blah blah
	 * blah blah blah
	 */

> +	ehci_sync_mem();
> +
>  	qh_get(qh);
>  	qh->xacterrs = 0;
>  	qh->qh_state = QH_STATE_LINKED;
> @@ -1082,6 +1088,18 @@ static struct ehci_qh *qh_append_tds (
>  			wmb ();
>  			dummy->hw_token = token;
>  
> +			/*
> +			 * Writing to dma coherent buffer on ARM may
> +			 * be delayed to reach memory, so HC may not see
> +			 * hw_token of dummy qtd in time, which can cause
> +			 * the qtd transaction to be executed very late,
> +			 * and degrade performance a lot. ehci_sync_mem
> +			 * is added to flush 'token' immediatelly into
> +			 * memory, so that ehci can execute the transaction
> +			 * ASAP.
> +			 * */

Here too.

> +			ehci_sync_mem();
> +
>  			urb->hcpriv = qh_get (qh);
>  		}
>  	}
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index cc7d337..313d9d6 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -738,6 +738,23 @@ static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
>  
>  #endif
>  
> +/*
> + * Writing to dma coherent memory on ARM may be delayed via L2
> + * writing buffer, so introduce the helper which can flush L2 writing
> + * buffer into memory immediately, especially used to flush ehci
> + * descriptor to memory.
> + * */

And here.

> +#ifdef	CONFIG_ARM_DMA_MEM_BUFFERABLE
> +static inline void ehci_sync_mem()
> +{
> +	mb();
> +}
> +#else
> +static inline void ehci_sync_mem()
> +{
> +}
> +#endif
> +

Except for the formatting of the comments, this is fine.  When you fix 
up the comments, you can add:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
