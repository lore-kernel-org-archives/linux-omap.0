From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
Date: Thu, 22 Sep 2016 11:07:18 -0700
Message-ID: <20160922180718.kmttyt26t56fa3kp@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
support bulk access") breaks at least omap4-duovero. I now get
tons of errors:

Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl 0-0048: PIH (irq 332) nested IRQs
of_get_named_gpiod_flags: parsed 'ti,audpwron-gpio' property of node '/ocp/i2c@48070000/t
wl@4b[0]' - status (0)
omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16

It seems the regmap irqs don't work with use_single_rw?

Also seems that twl6040 does support bulk access as things have been
working earlier?

Anyways, can you please revert?

Regards,

Tony
