From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] Bluetooth: hci_ll: set operational frequency earlier
Date: Mon, 30 Sep 2019 15:10:18 -0500
Message-ID: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Philipp Puschmann <philipp.puschmann@emlix.com>
List-Id: linux-omap@vger.kernel.org

Is anyone else having issues with the hci_ll after  a2e02f38eff8
("Bluetooth: hci_ll: set operational frequency earlier") was applied?

I have an i.MX6Q with a WL1837MOD attached to UART2.  After this patch
I git a bunch of timeouts when initializing the device using the 5.3
and 5.3.1 kernel.   I know a bunch of omap and imx users have done
some various tests over the years, so I thought I'd ask.

[  195.911836] Bluetooth: hci0: command 0xff36 tx timeout
[  206.071837] Bluetooth: hci0: command 0x1001 tx timeout
[  214.231862] Bluetooth: hci0: Reading TI version information failed (-110)
[  214.238712] Bluetooth: hci0: download firmware failed, retrying...
[  216.391834] Bluetooth: hci0: command 0xff36 tx timeout
[  226.551843] Bluetooth: hci0: command 0x1001 tx timeout
[  234.711856] Bluetooth: hci0: Reading TI version information failed (-110)
[  234.718705] Bluetooth: hci0: download firmware failed, retrying...
[  236.871832] Bluetooth: hci0: command 0xff36 tx timeout
[  247.031837] Bluetooth: hci0: command 0x1001 tx timeout
[  255.191852] Bluetooth: hci0: Reading TI version information failed (-110)
[  255.198706] Bluetooth: hci0: download firmware failed, retrying...
Can't init device hci0: Connection timed out (110)

Revering this patch fixes the issue, and subsequent patch proposals
form Philipp haven't seemed to fix the issues for me on 5.3

adam
