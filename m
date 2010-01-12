From: Qypea <q-newsgroup@qypea.com>
Subject: [RFC] omap2_mcspi interrupt context execution
Date: Mon, 11 Jan 2010 20:42:34 -0800
Message-ID: <181e7c7e1001112042h424b6ab6q79d6c043bc7fd03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39635 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0ALEmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 23:42:35 -0500
Received: by yxe17 with SMTP id 17so21029402yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 20:42:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

List,
One of the devices I work with has an ethernet chip connected to an
OMAP2430 by spi and an interrupt gpio. The chip isn't well behaved, so
I end up needing to send spi messages in response to interrupts from
the chip very quickly or it will lose packets.

I've written the high level driver such that it makes spi_async
requests in interrupt context when it gets an interrupt, but it
appears that the omap2_mcspi driver below me is context switching out
of interrupt context to a plain kernel thread. If the scheduler
doesn't run this thread immediately, we overflow the ethernet chip's
buffer and lose packets.

Has anyone looked into making the omap2_mcspi driver run in interrupt
context before? Does anyone have advice how to do so or a similar
driver I could pattern this change after?

Thanks,
David W

PS: Here's the psuedocode I'm imagining for the omap2_mcspi driver.
Maybe it will clarify what I'm thinking.

// Shared fifo of transfers yet to be handled
struct list pending_transfers;
spinlock_t lock;

// Called by upper layer drivers to send spi messages
int omap2_mcspi_transfer(struct spi_transfer * t)
{
=A0 =A0 =A0 spin_lock(lock);
=A0 =A0 =A0 empty =3D list_empty(pending_transfers);
=A0 =A0 =A0 list_push_back(pending_transfers, t);
=A0 =A0 =A0 if (empty) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 start_transfer();
=A0 =A0 =A0 }
=A0 =A0 =A0 spin_unlock(lock);

=A0 =A0 =A0 return status;
}

void start_transfer()
{
=A0 =A0 =A0 struct spi_transfer * t =3D pending_transfers.first;
=A0 =A0 =A0 spi_enable(t.channel);
=A0 =A0 =A0 spi_setup(t.channel, t.params);

=A0 =A0 =A0 setup_dma(spi, t.tx_buf, t.rx_buf, t.length, irq_handler);
=A0 =A0 =A0 spi_start();
}

// Called when dma completes to+from mcspi
void irq_handler()
{
=A0 =A0 =A0 struct spi_transfer * t =3D pending_transfers.first;

=A0 =A0 =A0 spin_lock(lock);
=A0 =A0 =A0 spi_finish(t);
=A0 =A0 =A0 spi_disable(t.channel);

=A0 =A0 =A0 list_remove(pending_transfers, t);
=A0 =A0 =A0 if !list_empty(pending_transfers) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 start_transfer();
=A0 =A0 =A0 }
=A0 =A0 =A0 spin_unlock(lock);

=A0 =A0 =A0 // Call back to the driver to let it know we finished
=A0 =A0 =A0 t.async_callback(t.status);
}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
