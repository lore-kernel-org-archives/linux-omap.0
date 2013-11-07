From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 09:34:31 -0600
Message-ID: <527BB307.7090401@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383164468-4610-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: nsekhar@ti.com, s.neumann@raumfeld.com, linux-arm-kernel@lists.infradead.org, Russ.Dill@ti.com
List-Id: linux-omap@vger.kernel.org

On 10/30/2013 03:21 PM, Daniel Mack wrote:
[...]
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 8e1a024..f15cdb9 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c

[...]

> +static int edma_pm_suspend(struct device *dev)
> +{
> +	int j;
> +
> +	pm_runtime_get_sync(dev);
> +
error checks?
> +	for (j = 0; j < arch_num_cc; j++) {
> +		struct edma *ecc = edma_cc[j];
> +
> +		disable_irq(ecc->irq_res_start);
> +		disable_irq(ecc->irq_res_end);
> +	}
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static int edma_pm_resume(struct device *dev)
> +{
> +	int i, j;
> +
> +	pm_runtime_get_sync(dev);
error checks?

[...]


-- 
Regards,
Nishanth Menon
