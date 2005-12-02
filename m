From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Uploading problem in OSK5912
Date: Fri, 2 Dec 2005 09:44:54 -0600
Message-ID: <520AB2AD990DC04082102F77CA17263801E541AE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: naga rajan <nagubk82@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a generic issue,
> *(i)how to upload and execute the applications in the kernel without
using
> network server access ?*
Without using ethernet, You have lots of options:
jtag/flash/uart/usb(ost host) etc.. One excellent documentation I have
seen for osk is: http://oskfordummies.hp.infoseek.co.jp/howto.html. Also
u might be interested in checking out
http://linux.omap.com/pub/documentation/ for more data (some docs from
other platforms might be generic enough to be useful). Ofcourse, google
is a nice place to start off, and surely you can try checking this
mailing list and the arm linux mailing list archives too..

>=20
> *(ii) how to fuse my application into the flash?*.
>=20
To flash it use the uboot itself(if u already have one uboot on board) -
it should support flashing options. Protect off, erase , cp commands
should be good enough for NOR flash. There is help for the same within
uboot itself (type help at uboot command prompt)
Or u can use the ost host tool as described in the oskfordummies.

>=20
> *(iii)Is there any terminal program(like minicom,hyperterminal) to
upload
> the executable file into the kernel for "tftp"?*.
Ok.. I assume that u would like to download kernel? Or do u want to
download a filesystem? Let me try either one of them
Onboard, u can use the loadb command that can take a file
(uImage/uboot.bin/some bin) over serial port using Kermit. Once u have a
filesystem (either ramdisk/jffs2 based flash/nfs filesystem) u can boot
ur kernel. But a kernel alone will not be of much use to u. the apps
need to reside on the filesystem. Once u have the filesystem is
available and u have some sort of prompt, check the filesystem apps
available. They should behave as if you are on a normal linux box.

Regards,
Nishanth Menon
