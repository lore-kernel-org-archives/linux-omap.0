From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 4/6] irqchip/irq-pruss-intc: Add helper functions to
 configure internal mapping
Date: Thu, 8 Aug 2019 13:31:06 -0500
Message-ID: <5a81f82a-2cba-7ec5-ced2-714516319d6a@lechnology.com>
References: <20190731224149.11153-1-s-anna@ti.com>
 <20190731224149.11153-5-s-anna@ti.com>
 <1a63eb50-7c5c-eb3d-3cbe-bd1cc59ce3fe@kernel.org>
 <89abc27f-5d02-a8ce-df0e-b185c2a647cd@ti.com>
 <1ac233f6-f3a3-6cec-9ad2-49e985fdfaca@lechnology.com>
 <6c17875e-496d-1277-278f-239d3a9d8ca2@ti.com>
 <124b03b8-f8e7-682b-8767-13a739329da2@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <124b03b8-f8e7-682b-8767-13a739329da2@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/8/19 12:09 PM, David Lechner wrote:
> 
> Then we can provide a vendor resource hook in the remoteproc driver to handle
> these resources:
> 
> static int ti_pru_rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc,
>                     int offset, int avail)
> {
>      struct ti_pru_data *pru = rproc->priv;
>      struct irq_fwspec fwspec;
>      unsigned int virq;
> 
>      switch (rsc_type) {
>      case TI_PRU_VENDOR_RESOURCE_IRQ:
>      {
>          struct ti_pru_vendor_resource_irq *rsc_irq = rsc;
> 
>          fwspec.fwnode = pru->intc_fwnode;
>          fwspec.param[0] = le32_to_cpu(rsc_irq->event);
>          fwspec.param[1] = le32_to_cpu(rsc_irq->channel);
>          fwspec.param[2] = le32_to_cpu(rsc_irq->host);
>          fwspec.param[3] = le32_to_cpu(rsc_irq->domain);
>          fwspec.param_count = 4;
>      }
>          break;
>      case TI_PRU_VENDOR_RESOURCE_IRQ2:
>      {
>          struct ti_pru_vendor_resource_irq2 *rsc_irq2 = rsc;
> 
>          fwspec.fwnode = pru->intc_fwnode;
>          fwspec.param[0] = le32_to_cpu(rsc_irq2->event);
>          fwspec.param[1] = le32_to_cpu(rsc_irq2->evt_sel);
>          fwspec.param[2] = le32_to_cpu(rsc_irq2->channel);
>          fwspec.param[3] = le32_to_cpu(rsc_irq2->host);
>          fwspec.param[4] = le32_to_cpu(rsc_irq2->domain);
>          fwspec.param_count = 5;
>          break;
>      }
>      default:
>          return RSC_IGNORED;
>      }
> 
>      virq = irq_create_fwspec_mapping(&fwspec);
>      if (!virq)
>          return -EINVAL;
> 
>      /* TODO: save virq (and other metadata) for later use */
> 
>      return RSC_HANDLED;
> }
> 
> static const struct rproc_ops ti_pru_rproc_ops = {
>      .start = ti_pru_rproc_start,
>      .stop = ti_pru_rproc_stop,
>      .kick = ti_pru_rproc_kick,
>      .da_to_va = ti_pru_rproc_da_to_va,
>      .handle_rsc = ti_pru_rproc_handle_rsc,
> };
> 

After re-reading some of the previous discussions, it sounds like
we wouldn't want to always map every IRQ in the firmware resource
table.

In that case, we could implement the rproc_ops parse_fw callback
instead. All firmware nodes could be collected (from both the
firmware resource table and device tree) and the remoteproc driver
could decide which ones need to be mapped and which ones don't.
Then it could call irq_create_fwspec_mapping() only the nodes
that need to be mapped based on the current application.
