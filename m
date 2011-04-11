From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [regression] 2.6.39-rc1 - Beagleboard usbnet broken
Date: Mon, 11 Apr 2011 21:33:44 +0200
Message-ID: <201104112133.44794.maciej.rutecki@gmail.com>
References: <4D998DC9.3040109@mimc.co.uk>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D998DC9.3040109@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D33092
for your bug report, please add your address to the CC list in there, t=
hanks!

On poniedzia=C5=82ek, 4 kwietnia 2011 o 11:22:17 Mark Jackson wrote:
> Running 2.6.38 on my beagleboard, I can boot using nfs:-
>=20
> regulator_init_complete: VDVI: incomplete constraints, leaving on
> regulator_init_complete: VDAC: incomplete constraints, leaving on
> usb 1-2: new high speed USB device using ehci-omap and address 2
> mmc0: host does not support reading read-only switch. assuming
> write-enable. mmc0: new high speed SDHC card at address 1234
> usb 1-2: New USB device found, idVendor=3D0424, idProduct=3D9514
> usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D=
0
> mmcblk0: mmc0:1234 SA04G 3.67 GiB
> hub 1-2:1.0: USB hub found
>  mmcblk0: p1
> hub 1-2:1.0: 5 ports detected
> usb 1-2.1: new high speed USB device using ehci-omap and address 3
> usb 1-2.1: New USB device found, idVendor=3D0424, idProduct=3Dec00
> usb 1-2.1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=
=3D0
> smsc95xx v1.0.4
> smsc95xx 1-2.1:1.0: usb0: register 'smsc95xx' at usb-ehci-omap.0-2.1,
> smsc95xx USB 2.0 Ethernet, 9e:79:dd:1e:2e:5c
> Sending DHCP requests .
> usb0: link up, 100Mbps, full-duplex, lpa 0x45E1
> ., OK
> IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.113
> IP-Config: Complete:
>      device=3Dusb0, addr=3D10.0.0.113, mask=3D255.255.0.0, gw=3D10.0.=
0.1,
>      host=3D10.0.0.113, domain=3D, nis-domain=3D(none),
>      bootserver=3D10.0.0.1, rootserver=3D10.0.0.100, rootpath=3D
> VFS: Mounted root (nfs filesystem) on device 0:10.
> .... etc ....
>=20
> I have just tried out 2.6.39-rc1, and the usbnet is no longer detecte=
d:-
>=20
> regulator_init_complete: VDVI: incomplete constraints, leaving on
> regulator_init_complete: VDAC: incomplete constraints, leaving on
> mmc0: host does not support reading read-only switch. assuming
> write-enable. mmc0: new high speed SDHC card at address 1234
> mmcblk0: mmc0:1234 SA04G 3.67 GiB
>  mmcblk0: p1
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)
> Please append a correct "root=3D" boot option; here are the available
> partitions: b300         3858432 mmcblk0  driver: mmcblk
>   b301           72261 mmcblk0p1 00000000-0000-0000-0000-000000000mmc=
blk0p1
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(2,0)
>=20
> I have tried a git bisect, but it seems to blame the wrong thing:-
>=20
> 087809fce28f50098d9c3ef1a6865c722f23afd2 is the first bad commit
> commit 087809fce28f50098d9c3ef1a6865c722f23afd2
> Author: Jamie Iles <jamie@jamieiles.com>
> Date:   Fri Jan 21 14:11:52 2011 +0000
>=20
>     dmaengine/dw_dmac: don't scan descriptors if no xfers in progress
>=20
>     Some hardware (picoChip picoXCell in particular) sometimes has
>     the block transfer complete bit being set for a channel after the
>     whole transfer has completed. If we don't have any transfers in t=
he
>     active list then don't bother to scan the descriptors. This often
>     happens in normal operation and doesn't require the channel to be
>     reset.
>=20
>     v2: cleanup whitespace
>=20
>     Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>=20
> :040000 040000 d0dac7f65b52fb1849f77056740d84d06530629f
> :211910a820dad07f0439410cc849c34909a62c2f M
>=20
> drivers
>=20
> I have attached my .config.  Can anyone help ?
>=20
> Cheers
> Mark

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
