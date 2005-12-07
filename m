From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Re: Uploading problem in OSK5912
Date: Wed, 7 Dec 2005 08:53:46 -0600
Message-ID: <520AB2AD990DC04082102F77CA17263801F15E3C@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: naga rajan <nagubk82@gmail.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Nagarajan,

I Use something as follows:

setenv bootargs 'mem=3D32M console=3DttyS0,115200n8 noinitrd =
root=3D/dev/nfs
rw nfsroot=3D<serverIP>:<MntPath>,vers=3D2,rsize=3D1024,wsize=3D1024 =
ip=3Ddhcp
devfs=3Dmount'

for a 2.4 kernel.

Check if you are able to do a "mount -t nfs '<serverIP>:<MntPath>' -o
'vers=3D2,rsize=3D1024,wsize=3D1024'" from another linux box. If this =
works,
then the above boot args should work.

Note: the vers argument is needed for some nfs servers..

Regards,

Nishanth Menon

=20

=20

________________________________

From: naga rajan [mailto:nagubk82@gmail.com]=20
Sent: Wednesday, December 07, 2005 12:17 AM
To: Menon, Nishanth
Cc: Jose Manuel Cano Garcia; Linux OMAP Open Source
Subject: Re: Re: Uploading problem in OSK5912

=20

Hi,


 While mounting the filesystem using NFS, the following error occurred.
DHCP configures the IP address properly(192.168.0.150). What could be
the problem?=20

=20

Looking up port of RPC 100003/2 on 192.168.0.121

Looking up port of RPC 100005/1 on 192.168.0.121

Root-NFS: Server returned error -13 while mounting
/tftpboot/serverip:/home/sach

in/montavista/filesys

VFS: Unable to mount root fs via NFS, trying floppy.

VFS: Cannot open root device "nfs" or 02:00

Please append a correct "root=3D" boot option

Kernel panic: VFS: Unable to mount root fs on 02:00

=20

Please provide a solution for this problem.

Thanks in advance,

B.Nagarajan,

SANDS.

=20


=20

On 12/3/05, Nishanth Menon <x0nishan@dlemailx.itg.ti.com> wrote:=20

>>
>>*mount fs type jffs2 not supported by the kernel.*
>>
Please read the section on how to enable Jffs2 in the kernel - make
menuconfig, filesystem, check for MTD if flash driver is enabled etc..=20

If u dont have jffs2 available consider using ramdisk option too if ur
filesystem is small and you dont care about files generated/modified
after bootup.

---------Included Message----------
>Date: Sat, 3 Dec 2005 06:19:45 -0600=20
>From: "Jose Manuel Cano Garcia" <jcgarcia@uma.es>
>To: "naga rajan" <nagubk82@gmail.com>, "Linux OMAP Open Source" <
linux-omap-open-source@linux.omap.com>
>Subject: Re: Uploading problem in OSK5912
>
>Hi,
>
>In the howto from oskfordummies a 2.6 kernel is recommended. Anyway, I
>supose you just have to recompile the kernel with jffs2 filesystem
>support and reflash it to the osk 5912 board.
>
>Nevertheless...why are you reflashing the board if you are using the=20
>original montavista preview kit? Why not just download a .tar file with
>your application to the board original filesystem?
>
>
>naga rajan wrote:
>
>>Dear Nishanth,
>>=20
>>
>>
>>                        I followed up  the steps in the mail what u
have
>>sent for my query. I went through the documentation and copied the
>>filesystem to the flash. I m using the kernel 2.4.20-8.While mounting
the
>>filesystem to */mnt/flash*, the following error occurred.
>>
>>
>>
>>*mount fs type jffs2 not supported by the kernel.*
>>
>>
>>
>>            In the OSK5912 guide, it is mentioned to use redhat
7/9.Could
>>you tell me the way to get jffs2 for kernel 2.4.20-8 or any changes to
be
>>done to get the solution for the above problem? Waiting for your
positive=20
>>reply.
>>
>>
>>
>>Thanks and regards....
>>
>>B.Nagarajan,
>>
>>SANDS.
>>
>>
>>On 12/2/05, Menon, Nishanth < x0nishan@ti.com <mailto:x0nishan@ti.com>
> wrote:
>>
>>
>>>This is a generic issue,
>>>
>>>
>>>>*(i)how to upload and execute the applications in the kernel without
>>>>=20
>>>>
>>>using
>>>
>>>
>>>>network server access ?*
>>>>
>>>>
>>>Without using ethernet, You have lots of options:=20
>>>jtag/flash/uart/usb(ost host) etc.. One excellent documentation I
have
>>>seen for osk is: http://oskfordummies.hp.infoseek.co.jp/howto.html .
Also
>>>u might be interested in checking out
>>>http://linux.omap.com/pub/documentation/ for more data (some docs
from
>>>other platforms might be generic enough to be useful). Ofcourse,
google=20
>>>is a nice place to start off, and surely you can try checking this
>>>mailing list and the arm linux mailing list archives too..
>>>
>>>
>>>
>>>>*(ii) how to fuse my application into the flash?*.=20
>>>>
>>>>
>>>>
>>>To flash it use the uboot itself(if u already have one uboot on
board) -
>>>it should support flashing options. Protect off, erase , cp commands=20
>>>should be good enough for NOR flash. There is help for the same
within
>>>uboot itself (type help at uboot command prompt)
>>>Or u can use the ost host tool as described in the oskfordummies.=20
>>>
>>>
>>>
>>>>*(iii)Is there any terminal program(like minicom,hyperterminal) to
>>>>
>>>>
>>>upload
>>>
>>>=20
>>>>the executable file into the kernel for "tftp"?*.
>>>>
>>>>
>>>Ok.. I assume that u would like to download kernel? Or do u want to
>>>download a filesystem? Let me try either one of them=20
>>>Onboard, u can use the loadb command that can take a file
>>>(uImage/uboot.bin/some bin) over serial port using Kermit. Once u
have a
>>>filesystem (either ramdisk/jffs2 based flash/nfs filesystem) u can
boot=20
>>>ur kernel. But a kernel alone will not be of much use to u. the apps
>>>need to reside on the filesystem. Once u have the filesystem is
>>>available and u have some sort of prompt, check the filesystem apps=20
>>>available. They should behave as if you are on a normal linux box.
>>>
>>>Regards,
>>>Nishanth Menon
>>>
>>>
>>>
>>>---------------------------------------------------------------------
---=20
>>>
>>>_______________________________________________
>>>Linux-omap-open-source mailing list
>>>Linux-omap-open-source@linux.omap.com=20
>>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>>
>>>
>
>_______________________________________________=20
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
<http://linux.omap.com/mailman/listinfo/linux-omap-open-source>=20
>
>
---------End of Included Message----------



=20
