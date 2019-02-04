From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver
 for PRUSS interrupts
Date: Mon, 4 Feb 2019 08:36:37 -0800
Message-ID: <20190204163637.GK5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549290167-876-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190204 14:23]:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.

Acked-by: Tony Lindgren <tony@atomide.com>
