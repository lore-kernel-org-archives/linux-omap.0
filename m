From: Roger Quadros <rogerq@ti.com>
Subject: Re: Help needed USB hub disconnected at resume
Date: Mon, 3 Mar 2014 13:06:13 +0200
Message-ID: <53146225.8040403@ti.com>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local>,<F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local> <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836AbaCCLGV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 06:06:21 -0500
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Marc,

On 03/03/2014 12:04 PM, Marc Murphy wrote:
> Hi,
> I am using the latest stable 3.4.80 kernel with some changes to get the EMAC Phy to initialise correctly after a suspend/resume.  The platform is AM3517 with most of the system working nice and smoothly. I have 1 issue though and need some advice/help to get the system to use the USB hub I have connected to the EHCI controller after a suspend to memory and resume.
> 
> At boot all is recognised;
> 
> [    1.486816] usbcore: registered new interface driver cdc_ether
> [    1.493255] usbcore: registered new interface driver cdc_ncm
> [    1.499450] usbcore: registered new interface driver qmi_wwan
> [    1.506622] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.513580] ehci-omap.0 supply hsusb0 not found, using dummy regulator
> [    2.521881] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> [    2.528411] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
> [    2.536468] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> [    2.553070] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> [    2.559295] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    2.566436] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.574035] usb usb1: Product: OMAP-EHCI Host Controller
> [    2.579620] usb usb1: Manufacturer: Linux 3.4.80 ehci_hcd
> [    2.585296] usb usb1: SerialNumber: ehci-omap.0
> [    2.591278] hub 1-0:1.0: USB hub found
> [    2.595306] hub 1-0:1.0: 3 ports detected
> 
> And I can see everything OK.
> 
> # lsusb
> Bus 001 Device 002: ID 0424:2513 Standard Microsystems Corp. 2.0 Hub
> Bus 002 Device 002: ID 05e3:0718 Genesys Logic, Inc. IDE/SATA Adapter
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 003: ID 1199:68a2 Sierra Wireless, Inc.
> #
> #
> # echo mem > /sys/power/state
> [   73.736572] PM: Syncing filesystems ... done.
> [   73.743530] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   73.766784] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   73.959289] davinci_mdio davinci_mdio.0: timed out waiting for idle
> [   73.968872] PM: suspend of devices complete after 170.410 msecs
> [   73.975433] PM: late suspend of devices complete after 0.305 msecs
> [   73.982635] PM: noirq suspend of devices complete after 0.732 msecs
> [   83.430450] Powerdomain (core_pwrdm) didn't enter target state 1
> [   83.436737] Could not enter target state in pm_suspend
> [   83.443176] PM: noirq resume of devices complete after 0.915 msecs
>  [   83.450164] PM: early resume of devices complete after 0.274 msecs
> [   83.457336] <6>Waiting for PHY clock good...
> [   83.463287] davinci_mdio davinci_mdio.0: resetting idled controller
> [   83.471343] net eth0: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=davinci_mdio-0:00, id=7c0f1)
> [   84.771881] PM: resume of devices complete after 1315.185 msecs
> [   84.778472] Restarting tasks ...
> [   84.782379] usb 1-1: USB disconnect, device number 2
> [   84.790557] done.
> [   84.792938] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> sh: write error:[   84.800781] usb 1-1.1: USB disconnect, device number 3
>  Operation not p[   84.808349] qmi_wwan 1-1.1:1.8: wwan0: unregister 'qmi_wwan' usb-ehci-omap.0-1.1, Sierra Wireless wwan/QMI device
> ermitted
> [   84.859191] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [   86.490356] PHY: davinci_mdio-0:00 - Link is Up - 100/Full
> #
> #
> # lsusb
> Bus 002 Device 002: ID 05e3:0718 Genesys Logic, Inc. IDE/SATA Adapter
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> #
> 
> Is there any relevant patch out there that would address the issue that I see ?

Does this happen because of OFF mode?
Can you please try the tests with off mode disabled?

e.g.
mount -t debugfs none /sys/kernel/debug
echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode
suspend & resume

Also please send the output of /sys/kernel/debug/pm_debug/count
before suspend and after resume. Thanks.

cheers,
-roger
