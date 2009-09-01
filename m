From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
Date: Tue, 1 Sep 2009 20:28:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9AF18DC@dbde02.ent.ti.com>
References: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com>
	 <F12CE1A68F023D498A2691C7B539311503935B24@ZMY16EXM66.ds.mot.com>
 <d6a0f7aa0909010013n2c9334cdt56afa642e2a0617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509AbZIAO6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 10:58:09 -0400
In-Reply-To: <d6a0f7aa0909010013n2c9334cdt56afa642e2a0617@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>, HU TAO-TGHK48 <taohu@motorola.com>
Cc: vimal singh <vimal.newwork@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>, Chen Xiaolong-A21785 <A21785@motorola.com>

govindraj

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.k=
ernel.org] On Behalf Of
>Govindraj
>Sent: Tuesday, September 01, 2009 2:14 AM
>To: HU TAO-TGHK48
>Cc: vimal singh; linux-omap@vger.kernel.org; LKML; linux-serial@vger.k=
ernel.org; Ye Yuan.Bo-A22116;
>Chen Xiaolong-A21785
>Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
>
>On Mon, Aug 31, 2009 at 5:20 PM, HU TAO-TGHK48<taohu@motorola.com> wro=
te:
>>
>> 1. Shall we cleanup PM related stuff in arch/arm/mach-omap2/serial.c=
 as
>> well?
>> =A0 =A0Originally serail.c register UART IRQ =A0to decide if UART id=
le for a
>> while and is able to enter low power mode (e.g. retention).
>> =A0 =A0To work with original 8250 driver, it is probably the only wa=
y since
>> 8250 is not aware of OMAP PM.
>>
>> =A0 =A0However =A0it would be more reasonable to merge PM stuff to
>> omap-serial.c. since the new driver is already OMAP specific
>>
>> 2. There is an issue for DMA =A0with current implementation in seria=
l.c
>> =A0 =A0When Rx DMA is active NO Rx IRQ will be generated.
>> =A0 =A0So serial.c will easily set uart->can_sleep with "1" even the=
re is
>> Rx DMA ongoing
>> =A0 =A0+ =A0 if ((iir & 0x4) && up->use_dma) {
>> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_RDI;
>> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier
>>
>> =A0 In my view, the best way is to do the idle detection in
>> omap_serial.c.
>
>Yes I understand that we cannot adapt 8250 PM model for omap-serial
>driver in DMA mode I am currently working on that adaption with dma
>mode and will be posting a separate patch for changes on serial.c.
>
>Wouldn't it be cleaner to inherit and adapt the Serial-PM framework
>from serial.c rather than redefining the PM changes in the driver.
>
>As Serial-PM framework already has support for interrupt mode and we
>have to adapt the same for DMA  mode.
>
>Also defining PM changes in omap-serial would need changes in PM frame=
work.
>As PM framework calls functions from serail.c file if we are defining
>PM framework in our driver then we may need to redefine the functions
>as in serial.c or modify the PM-framework for uart-activity check.
>I feel adapting the existing serial-PM framework for DMA mode would be
>better rather than
>doing these changes.

You can take reference of how to integrate omap-serial driver PM=20
with mach-omap2/serial.c as follows, for reference ---=20


---
=46rom 69112426bd6009cb11e104b9aafcc65429d662f0 Mon Sep 17 00:00:00 200=
1
=46rom: Vikram Pandita <vikram.pandita@ti.com>
Date: Fri, 21 Aug 2009 11:15:58 -0500
Subject: [RFC PATCH] OMAP: Serial: Keep uart in no idle mode when DMA o=
ngoing

Keep UART in NoIdle mode when DMA is going on.

Only once UART transfers are complete, switch to smart idle and
allow OsIdle to kick in

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/serial.c |   12 ++++++++++++
 drivers/serial/omap-serial.c |    2 +-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index ff9beb7..a6ee6ab 100755
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -359,9 +359,21 @@ static void omap_uart_allow_sleep(struct omap_uart=
_state *uart)
 	del_timer(&uart->timer);
 }
=20
+extern int are_driveromap_uarts_active(int *);
+
 static void omap_uart_idle_timer(unsigned long data)
 {
 	struct omap_uart_state *uart =3D (struct omap_uart_state *)data;
+	int dummy;
+
+	if (are_driveromap_uarts_active(&dummy)){
+		/* Keep UART on NoIdle when DMA channel is enabled in omap
+		 * serial: do not allow UART to goto Smart-idle till its done
+		 * dma'ing
+		 */
+		omap_uart_block_sleep(uart);
+		return;
+	}
=20
 	omap_uart_allow_sleep(uart);
 }
diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.=
c
index 938f29f..f105e24 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -1641,6 +1641,7 @@ int omap24xx_uart_cts_wakeup(int uart_no, int sta=
te)
 	return 0;
 }
 EXPORT_SYMBOL(omap24xx_uart_cts_wakeup);
+#endif
 /**
  * are_driver8250_uarts_active() - Check if any ports managed by this
  * driver are currently busy.  This should be called with interrupts
@@ -1709,7 +1710,6 @@ int are_driveromap_uarts_active(int *driver8250_m=
anaged)
 }
 EXPORT_SYMBOL(are_driveromap_uarts_active);
=20
-#endif
=20
 static void serial_omap_display_reg(struct uart_port *port)
 {
--=20
1.6.3.3.334.g916e1


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
