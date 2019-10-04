From: Adam Ford <aford173@gmail.com>
Subject: DM3730 Bluetooth Performance differences between SERIAL_8250_OMAP vs SERIAL_OMAP
Date: Fri, 4 Oct 2019 05:02:05 -0500
Message-ID: <CAHCN7xLO5VgA6tW4p7QjwPv_QXv==zbC38TxXtsR5x9H0mUGJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

I am running Kernel 5.3.2 trying to troubleshoot some intermittent
Bluetooth issues, and I think I have narrowed it down to the serial
driver in use.
By default, omap2plus_defconfig enables both SERIAL_8250_OMAP and
SERIAL_OMAP.  I have my console device configured as  ttyS0, and all
appears fine.  When I enable Bluetooth, however, I get intermittent
errors on an DM3730 / OMAP3630.

Using the 8250 driver for Blueotooth I get intermittent frame errors
and data loss.

Scanning ...
[   28.482452] Bluetooth: hci0: Frame reassembly failed (-84)
[   36.162170] Bluetooth: hci0: Frame reassembly failed (-84)
        F4:4E:FC:C9:2F:57       BluJax
# l2ping F4:4E:FC:C9:2F:57
Ping: F4:4E:FC:C9:2F:57 from 00:18:30:49:7D:63 (data size 44) ...
44 bytes from F4:4E:FC:C9:2F:57 id 0 time 8.27ms
no response from F4:4E:FC:C9:2F:57: id 1
^C2 sent, 1 received, 50% loss

(after a fairly long hang, I hit control-c)

However, disabling the 8250 driver and using the only SERIAL_OMAP and
the console routed to ttyO0, the Bluetooth works well, so I believe it
to be a serial driver issue and not a Bluetooth error.

# hcitool scan
Scanning ...
        F4:4E:FC:C9:2F:57       BluJax
^C
# l2ping F4:4E:FC:C9:2F:57
Ping: F4:4E:FC:C9:2F:57 from 00:18:30:49:7D:63 (data size 44) ...
44 bytes from F4:4E:FC:C9:2F:57 id 0 time 6.90ms
...
44 bytes from F4:4E:FC:C9:2F:57 id 14 time 28.29ms
^C15 sent, 15 received, 0% loss
#

0% loss and regular, repeatable communication without any Frame
reassembly errors.

Any suggestions on how to troubleshoot or what might cause the
difference between the two drivers?

adam
