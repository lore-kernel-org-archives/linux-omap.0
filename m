From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 07:26:34 -0700
Message-ID: <20130710142633.GV5523@atomide.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
 <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22586 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754402Ab3GJO0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 10:26:39 -0400
Content-Disposition: inline
In-Reply-To: <87mwpuakod.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> Felipe Balbi <balbi@ti.com> writes:
> >> 
> >> Right, but calling serial_omap_restore_context() even when the context
> >> is not lost, should not ideally cause an issue.
> >
> > it does in one condition. If context hasn't been saved before. And that
> > can happen in the case of wrong pm runtime status for that device.
> >
> > Imagine the device is marked as suspended even though it's fully enabled
> > (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> > your context structure is all zeroes (context has never been saved
> > before) then when you call pm_runtime_get_sync() on probe() your
> > ->runtime_resume() will get called, which will restore context,
> > essentially undoing anything which was configured by u-boot.
> >
> > Am I missing something ?
> 
> You're right, the _set_active() is crucial in the case when we prevent
> the console UART from idling during boot (though that shouldn't be
> happening in mainline unless the fix for "Issue 1" is done.)

Felipe is right, looks like all we need is to check if context is
initialized or not. So no need for mach-omap2/serial.c or hwmod tinkering.

After that having DEBUG_LL and cmdline with earlyprintk console=ttyO..
works for me. We could also check for some combination of the context
save registers being NULL if somebody has a good idea which ones
should never be 0.

Regards,

Tony


--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -161,6 +161,7 @@ struct uart_omap_port {
 	u32			calc_latency;
 	struct work_struct	qos_work;
 	struct pinctrl		*pins;
+	bool			initialized;
 	bool			is_suspending;
 };
 
@@ -1523,6 +1524,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
+	up->initialized = true;
+
 	return 0;
 
 err_add_port:
@@ -1584,6 +1587,9 @@ static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
 #ifdef CONFIG_PM_RUNTIME
 static void serial_omap_restore_context(struct uart_omap_port *up)
 {
+	if (!up->initialized)
+		return;
+
 	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
 		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
 	else
