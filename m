From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: Re: [PATCH] Bluetooth: hci_ll: set operational frequency earlier
Date: Tue, 1 Oct 2019 09:04:26 +0200
Message-ID: <9525ffc4-3e1f-9941-8f7b-ba74690add77@emlix.com>
References: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

A few times i have seen this here too. The wl1837mod should definitely be able to set
the operaional frequency before loading the firmware.
It takes nearly 5 seconds to upload the firmware with 115kbps while only
0.2s with 3mbps. So i see a high interest to do it the fast way.
A problem i have identified may be the power supply. At least on my custom board
the power supply is controlled via gpio. But the serial bluetooth device has no
support for a regulator. As it is controlled by wifi driver only. I have prepared a patch
adding regulator support to hci_ll driver. In a few weeks i may try to get it upstream.

Another problem may be the timings. The timings the driver uses are according the wl1837mod
datasheets but it may that not all devices of that class or the wiring have the same
specifications and this causes the trouble.

For the above mentioned performance gain i would like to see the problem really solved.
It may be enough to add some sleep time or small delay or something of that kind in
ll_setup().

Regards,
Philipp


Am 30.09.19 um 22:10 schrieb Adam Ford:
> Is anyone else having issues with the hci_ll after  a2e02f38eff8
> ("Bluetooth: hci_ll: set operational frequency earlier") was applied?
> 
> I have an i.MX6Q with a WL1837MOD attached to UART2.  After this patch
> I git a bunch of timeouts when initializing the device using the 5.3
> and 5.3.1 kernel.   I know a bunch of omap and imx users have done
> some various tests over the years, so I thought I'd ask.
> 
> [  195.911836] Bluetooth: hci0: command 0xff36 tx timeout
> [  206.071837] Bluetooth: hci0: command 0x1001 tx timeout
> [  214.231862] Bluetooth: hci0: Reading TI version information failed (-110)
> [  214.238712] Bluetooth: hci0: download firmware failed, retrying...
> [  216.391834] Bluetooth: hci0: command 0xff36 tx timeout
> [  226.551843] Bluetooth: hci0: command 0x1001 tx timeout
> [  234.711856] Bluetooth: hci0: Reading TI version information failed (-110)
> [  234.718705] Bluetooth: hci0: download firmware failed, retrying...
> [  236.871832] Bluetooth: hci0: command 0xff36 tx timeout
> [  247.031837] Bluetooth: hci0: command 0x1001 tx timeout
> [  255.191852] Bluetooth: hci0: Reading TI version information failed (-110)
> [  255.198706] Bluetooth: hci0: download firmware failed, retrying...
> Can't init device hci0: Connection timed out (110)
> 
> Revering this patch fixes the issue, and subsequent patch proposals
> form Philipp haven't seemed to fix the issues for me on 5.3
> 
> adam
> 
