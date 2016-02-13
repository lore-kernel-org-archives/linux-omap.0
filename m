From: Tony Lindgren <tony@atomide.com>
Subject: Re: GPIO regression in Linux next caused by syscon change
Date: Fri, 12 Feb 2016 16:49:35 -0800
Message-ID: <20160213004935.GR19432@atomide.com>
References: <20160213002643.GQ19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160213002643.GQ19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160212 16:31]:
> Hi,
> 
> Looks like commit effe02710335 ("mfd: syscon: Set regmap max_register
> in of_syscon_register") somehow breaks smsc911x GPIO interrupt for
> me at least on omap3:
> 
> irq 241: nobody cared (try booting with the "irqpoll" option)
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc3-next-20160212 #864
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c010fd44>] (unwind_backtrace) from [<c010c094>] (show_stack+0x10/0x14)
> [<c010c094>] (show_stack) from [<c045f24c>] (dump_stack+0xb0/0xe4)
> [<c045f24c>] (dump_stack) from [<c01998e8>] (__report_bad_irq+0x24/0xc0)
> [<c01998e8>] (__report_bad_irq) from [<c0199ce4>] (note_interrupt+0x27c/0x2dc)
> [<c0199ce4>] (note_interrupt) from [<c0197220>] (handle_irq_event_percpu+0x184/0x200)
> [<c0197220>] (handle_irq_event_percpu) from [<c01972d4>] (handle_irq_event+0x38/0x5c)
> [<c01972d4>] (handle_irq_event) from [<c019a3d8>] (handle_level_irq+0xc0/0x154)
> [<c019a3d8>] (handle_level_irq) from [<c0196784>] (generic_handle_irq+0x20/0x34)
> [<c0196784>] (generic_handle_irq) from [<c049b690>] (omap_gpio_irq_handler+0x120/0x160)
> [<c049b690>] (omap_gpio_irq_handler) from [<c01970f0>] (handle_irq_event_percpu+0x54/0x200)
> [<c01970f0>] (handle_irq_event_percpu) from [<c01972d4>] (handle_irq_event+0x38/0x5c)
> [<c01972d4>] (handle_irq_event) from [<c019a3d8>] (handle_level_irq+0xc0/0x154)
> [<c019a3d8>] (handle_level_irq) from [<c0196784>] (generic_handle_irq+0x20/0x34)
> [<c0196784>] (generic_handle_irq) from [<c0196a78>] (__handle_domain_irq+0x64/0xe0)
> [<c0196a78>] (__handle_domain_irq) from [<c076f038>] (__irq_svc+0x58/0x78)
> [<c076f038>] (__irq_svc) from [<c076e93c>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [<c076e93c>] (_raw_spin_unlock_irqrestore) from [<c019900c>] (__setup_irq+0x40c/0x5e0)
> [<c019900c>] (__setup_irq) from [<c0199330>] (request_threaded_irq+0xc0/0x158)
> [<c0199330>] (request_threaded_irq) from [<c05a4038>] (smsc911x_drv_probe+0x588/0xfec)
> [<c05a4038>] (smsc911x_drv_probe) from [<c04fc1b4>] (platform_drv_probe+0x4c/0xb0)
> [<c04fc1b4>] (platform_drv_probe) from [<c04fa89c>] (driver_probe_device+0x208/0x2c0)
> [<c04fa89c>] (driver_probe_device) from [<c04fa9e8>] (__driver_attach+0x94/0x98)
> [<c04fa9e8>] (__driver_attach) from [<c04f8bc4>] (bus_for_each_dev+0x6c/0xa0)
> [<c04f8bc4>] (bus_for_each_dev) from [<c04f9d28>] (bus_add_driver+0x18c/0x214)
> [<c04f9d28>] (bus_add_driver) from [<c04fb22c>] (driver_register+0x78/0xf8)
> [<c04fb22c>] (driver_register) from [<c010180c>] (do_one_initcall+0x80/0x1dc)
> [<c010180c>] (do_one_initcall) from [<c0b00ef0>] (kernel_init_freeable+0x218/0x2ec)
> [<c0b00ef0>] (kernel_init_freeable) from [<c0768360>] (kernel_init+0x8/0xf4)
> [<c0768360>] (kernel_init) from [<c01078d0>] (ret_from_fork+0x14/0x24)
> handlers:
> [<c05a26d8>] smsc911x_irqhandler
> Disabling IRQ #241
> libphy: smsc911x-mdio: probed
> 
> I'm not seeing the connection between regmap and  GPIO, so no
> idea what goes wrong here.

The only regmap here is the scm_conf in omap3.dtsi. Probably some
resource size calculation issue causing an overlap?

Tony
