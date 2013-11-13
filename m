From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3 2/7] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
Date: Wed, 13 Nov 2013 10:27:08 -0500
Message-ID: <52839A4C.9080601@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383657257-3458-3-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sricharan R <r.sricharan@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, tony@atomide.com, linus.walleij@linaro.org, rnayak@ti.com, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, marc.zyngier@arm.com, galak@codeaurora.org, grant.likely@linaro.org, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the
> interrupt lines from the subsystems are not needed at the same
> time, so they have to be muxed to the irq-controller appropriately.
> In such places a interrupt controllers are preceded by an CROSSBAR
> that provides flexibility in muxing the device requests to the controller
> inputs.
> 
> This driver takes care a allocating a free irq and then configuring the
> crossbar IP as a part of the mpu's irqchip callbacks. crossbar_init should
> be called right before the irqchip_init, so that it is setup to handle the
> irqchip callbacks.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Acked-by: Kumar Gala <galak@codeaurora.org> (for DT binding portion)
> ---
As someone commented already, lets call the driver as irq-crossbar
since there might need of something similar for DMA and IO's.

So rename the code accordingly. Other than that,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
