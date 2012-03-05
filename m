From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: call all suspend,
 resume callbacks when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set
Date: Mon, 05 Mar 2012 07:21:39 -0800
Message-ID: <877gyzoyyk.fsf@ti.com>
References: <alpine.DEB.2.00.1203031314050.10611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1203031314050.10611@utopia.booyaka.com> (Paul
 Walmsley's message of "Sat, 3 Mar 2012 13:15:33 -0700 (MST)")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: John Stultz <johnstul@us.ibm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Green <andy.green@linaro.org>
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> During system suspend, when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set on
> an omap_device, call the corresponding driver's ->suspend() and
> ->suspend_noirq() callbacks (if present).  Similarly, during resume,
> the driver's ->resume() and ->resume_noirq() callbacks must both be
> called, if present.  (The previous code only called ->suspend_noirq()
> and ->resume_noirq().)
>
> If all of these callbacks aren't called, some important driver
> suspend/resume code may not get executed.
>
> In current mainline, the bug fixed by this patch is only a problem
> under the following conditions:
>
> - the kernel is running on an OMAP4
>
> - an OMAP UART is used as a console
>
> - the kernel command line parameter 'no_console_suspend' is specified
>
> - and the system enters suspend ("echo mem > /sys/power/state").
>
> Under this combined circumstance, the system cannot be awakened via
> the serial port after commit be4b0281956c5cae4f63f31f11d07625a6988766c
> ("tty: serial: OMAP: block idle while the UART is transferring data in
> PIO mode").  This is because the OMAP UART driver's ->suspend()
> callback is never called.  The ->suspend() callback would have called
> uart_suspend_port() which in turn would call enable_irq_wake().  Since
> enable_irq_wake() isn't called for the UART's IRQ, check_wakeup_irqs()
> would mask off the UART IRQ in the GIC.
>
> On v3.3 kernels prior to the above commit, serial resume from suspend
> presumably occurred via the PRCM interrupt.  The UART was in
> smart-idle mode, so it was able to send a PRCM wakeup which in turn
> would be converted into a PRCM interrupt to the GIC, waking up the
> kernel.  But after the above commit, when the system is suspended in
> the middle of a UART transmit, the UART IP block would be in no-idle
> mode.  In no-idle mode, the UART won't generate wakeups to the PRCM
> when incoming characters are received; only GIC interrupts.  But since
> the UART driver's ->suspend() callback is never called,
> uart_suspend_port() and enable_irq_wake() is never called; so the UART
> interrupt is masked by check_wakeup_irqs() and the UART can't wake up
> the MPU.
>
> The remaining mechanism that could have awakened the system would have
> been I/O chain wakeups.  These wouldn't be active because the console
> UART's clocks are never disabled when no_console_suspend is used,
> preventing the full chip from idling.  Also, current mainline doesn't
> yet support full chip idle states for OMAP4, so I/O chain wakeups are
> not enabled.
>
> This patch is the result of a collaboration.  John Stultz
> <johnstul@us.ibm.com> and Andy Green <andy.green@linaro.org> reported
> the serial wakeup problem that led to the discovery of this problem.
> Kevin Hilman <khilman@ti.com> narrowed the problem down to the use of
> no_console_suspend.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: John Stultz <johnstul@us.ibm.com>
> Cc: Andy Green <andy.green@linaro.org>
> Cc: Kevin Hilman <khilman@ti.com>

Looks right.

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, this fix is needed for v3.3.

Kevin
