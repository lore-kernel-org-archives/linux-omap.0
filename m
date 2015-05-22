From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: AM3517 usb host issue
Date: Fri, 22 May 2015 23:13:22 +0300
Message-ID: <555F8DE2.1050403@codethink.co.uk>
References: <555EE311.3030507@codethink.co.uk> <20150522135039.GA5582@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41647 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbbEVUN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 16:13:28 -0400
In-Reply-To: <20150522135039.GA5582@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux USB list <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 22/05/15 16:50, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 22, 2015 at 11:04:33AM +0300, Ben Dooks wrote:
>> I am trying to get the full-speed USB host working on an custom
>> AM3517 device with the 3.18.12 kernel. The hardware works (a
>> 2.6.37 kernel has been used for testing).
>> 
>> Does anyone have any experience of 3.18 (or similarly recent
>> kernel on an AM3517 system) or have any pointers as where to
>> start debugging? The ti-linux-3.14.y does not have any patches
>> that aren't applied to the usb on 3.18.13.
>> 
>> The cpu port 1 is connected by a TI TUSB1106 usb transceiver that
>> is directly connected to a full-speed hub (TI USB2046) hub so the
>> OHCI driver is the only one in use.
>> 
>> Note, the ohci-omap3 is loaded as a module as this is how their
>> user application expects to be able to shut down usb when it does
>> not need it.
>> 
>> The device tree configuration for the usb host:
> 
> and what exactly doesn't work ? That old OHCI driver hasn't been
> touched in years, it's no surprise that it stopped working :-(
> 
> Anyway, what exactly doesn't work ? No device enumerates ? Do you
> get any IRQs by plugging a new device in ?

I will check the interrupts when I get back into the office.

There is only one device (the hub) which isn't enumerating and is
hard-wired on the board.

>>> &usbhshost { status = "okay";	/* just in case it is started
>>> disabled */
>>> 
>>> port1-mode = "ohci-phy-6pin-dpdm"; };
>>> 
>>> &usbhsohci { status = "okay"; };
>>> 
>>> &usbhsehci { status = "disabled";	/* no ehci on board */ };
>> 
>> 
>> The usb from the logs is as follows. Some extra debugging has
>> been added to verify the device-tree settings:
>> 
>>> [    0.000000] AM3517 ES1.1 (l2cache sgx neon)
>>> 
>>> 
>>> [    0.869706] usbcore: registered new interface driver usbfs
>>>  [    0.874270] usbcore: registered new interface driver hub
>>>  [    0.878592] usbcore: registered new device driver usb
>>>  [    1.223199] usbhs_tll 48062000.usbhstll: starting TI HSUSB
>>> TLL Controller [    1.273000] usbhs_omap 48064000.usbhshost:
>>> ports 0 [    1.278291] usbhs_omap 48064000.usbhshost: port 0:
>>> ohci-phy-6pin-dpdm [    1.284476] usbhs_omap
>>> 48064000.usbhshost: port0-mode: ohci-phy-6pin-dpdm ->5 [
>>> 1.288689] usbhs_tll 48062000.usbhstll: omap_tll_init()
>>>  [    1.293628] usbhs_omap 48064000.usbhshost:
>>> usbhs_runtime_resume [    1.298434] usbhs_omap
>>> 48064000.usbhshost: sysconfig 0x00001009 [    1.302730]
>>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
>>>  [    1.307668] usbhs_omap 48064000.usbhshost:
>>> usbhs_runtime_suspend [    1.310142] stopping usb controller
>>>  [    1.419910] usbhs_tll 48062000.usbhstll: omap_tll_disable()
>>>  [    1.423547] usbhs_omap 48064000.usbhshost: 3 ports
>>>  [    1.429065] usbhs_omap 48064000.usbhshost: starting TI
>>> HSUSB Controller [    1.433831] usbhs_omap 48064000.usbhshost:
>>> usbhs_runtime_resume [    1.438625] usbhs_omap
>>> 48064000.usbhshost: sysconfig 0x00001009 [    1.442921]
>>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
>>>  [    1.448548] usbhs_omap 48064000.usbhshost:
>>> omap_usbhs_rev1_hostconfig => [    1.455034] usbhs_omap
>>> 48064000.usbhshost: UHH setup done, uhh_hostconfig=80d [
>>> 1.459918] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend
>>>  [    1.462337] stopping usb controller
>>>  [    1.569905] usbhs_tll 48062000.usbhstll: omap_tll_disable()
>>>  [    1.575408] usbhs_omap 48064000.usbhshost: populating usb
>>> sub nodes....
>>> 
>>> [   77.609168] usbhs_omap 48064000.usbhshost:
>>> usbhs_runtime_resume [   77.613927] usbhs_omap
>>> 48064000.usbhshost: sysconfig 0x00001009 [   77.618374]
>>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
>>>  [   77.802694] usb usb1: New USB device found, idVendor=1d6b,
>>> idProduct=0001 [   77.816003] usb usb1: New USB device strings:
>>> Mfr=3, Product=2, SerialNumber1 [   77.827391] usb usb1:
>>> Product: OHCI Host Controller [   77.838674] usb usb1:
>>> Manufacturer: Linux 3.18.13-00203-ga3c52be-dirty ohci_d [
>>> 77.849913] usb usb1: SerialNumber: 48064400.ohci
>>> 
> 
> OK, so this is roothub, what happens when a device is plugged to
> the other end ? Is VBUS charged ? We didn't even enumerate
> TUSB2046, did you look at its datasheet
> (http://www.ti.com/lit/ds/symlink/tusb2046b.pdf) ? What is the
> state of RESETn pin ? Perhaps that's tied to a GPIO and the old TI
> kernel toggles that ? Anything interesting from usbmon ?

I've gone through the schematics and verified the hub's reset line
is connected where we think it is (will try and check with a 'scope
on monday that it is being taken high, the boot-loader starts it low).

The root has just the one device connected, and unfortunately the
hw designer decided to hard-wire the D+ pull-up to 3.3V instead
of the transceiver's pull pin.

Not tried usbmon yet. However if the hub is not being detected then
probably won't show anything either.

I am going to install devmem2 into the root image and use it to poke
around and see the state of the system at run time.

Thanks for looking in to this.

- -- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVX43iAAoJEMuhVOkVU3uzaHUH/0rcRBoWJn07wuJZSDmX2cf7
pFV1jya+Qx1zJmVdwDfT1MLAW5XCdio5U+sZyWFe7mxbZd3IPXhMud4xAqjdEnvQ
amS3WcLVqbqLCbIq8KYKN6eSZqnf8gO2sPhSo3j86TpWyaQHstiS+FQu4Rv1v1XD
IUfXoQyp/taKihVcs7VvP6bT5lARr2lANGCJ6VAchHjLr04NM4VJUUXJ18m/Zxfm
A0Y6dJeLuT4MF9QpOd7KYVn2gYpdwtznF87J8gqJcYJHhggY1LWYBKiJSzBT6m/0
JYJldljoCEznro7G0ZaPMubWQO363SVEqDf3b7lmYuBKPo+7z/dr/KVmwiBf2a0=
=Hegi
-----END PGP SIGNATURE-----
