From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 10/17] soc: ti: pruss_intc: Add API to trigger a PRU
 sysevent
Date: Mon, 26 Nov 2018 15:18:25 -0600
Message-ID: <ff55c96e-21db-c361-2c99-4b1c8e6060aa@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-11-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-11-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The PRUSS INTC can generate an interrupt to various processor
> subsystems on the SoC through a set of 64 possible PRU system
> events. These system events can be used by PRU client drivers
> or applications for event notifications/signalling between PRUs
> and MPU or other processors. A new API, pruss_intc_trigger() is
> provided to MPU-side PRU client drivers/applications to be able
> to trigger an event/interrupt using IRQ numbers provided by the
> PRUSS-INTC irqdomain chip.

Could we just use something like this:

	irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);

instead of introducing a new API?
