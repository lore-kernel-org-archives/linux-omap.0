From: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Subject: Re: Uploading problem in OSK5912
Date: Sat, 03 Dec 2005 13:19:45 +0100
Message-ID: <43918D61.90000@uma.es>
References: <520AB2AD990DC04082102F77CA17263801E541AE@dlee03.ent.ti.com>
	<7e6cc7550512030403u1a48a95cx2f3417e4b37bf121@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7e6cc7550512030403u1a48a95cx2f3417e4b37bf121@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: naga rajan <nagubk82@gmail.com>, Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

In the howto from oskfordummies a 2.6 kernel is recommended. Anyway, I=20
supose you just have to recompile the kernel with jffs2 filesystem=20
support and reflash it to the osk 5912 board.

Nevertheless...why are you reflashing the board if you are using the=20
original montavista preview kit? Why not just download a .tar file with=20
your application to the board original filesystem?


naga rajan wrote:

>Dear Nishanth,
>
>
>
>                        I followed up  the steps in the mail what u have
>sent for my query. I went through the documentation and copied the
>filesystem to the flash. I m using the kernel 2.4.20-8.While mounting th=
e
>filesystem to */mnt/flash*, the following error occurred.
>
>
>
>*mount fs type jffs2 not supported by the kernel.*
>
>
>
>            In the OSK5912 guide, it is mentioned to use redhat 7/9.Coul=
d
>you tell me the way to get jffs2 for kernel 2.4.20-8 or any changes to b=
e
>done to get the solution for the above problem? Waiting for your positiv=
e
>reply.
>
>
>
>Thanks and regards=85.
>
>B.Nagarajan,
>
>SANDS.
>
>
>On 12/2/05, Menon, Nishanth <x0nishan@ti.com> wrote:
> =20
>
>>This is a generic issue,
>>   =20
>>
>>>*(i)how to upload and execute the applications in the kernel without
>>>     =20
>>>
>>using
>>   =20
>>
>>>network server access ?*
>>>     =20
>>>
>>Without using ethernet, You have lots of options:
>>jtag/flash/uart/usb(ost host) etc.. One excellent documentation I have
>>seen for osk is: http://oskfordummies.hp.infoseek.co.jp/howto.html. Als=
o
>>u might be interested in checking out
>>http://linux.omap.com/pub/documentation/ for more data (some docs from
>>other platforms might be generic enough to be useful). Ofcourse, google
>>is a nice place to start off, and surely you can try checking this
>>mailing list and the arm linux mailing list archives too..
>>
>>   =20
>>
>>>*(ii) how to fuse my application into the flash?*.
>>>
>>>     =20
>>>
>>To flash it use the uboot itself(if u already have one uboot on board) =
-
>>it should support flashing options. Protect off, erase , cp commands
>>should be good enough for NOR flash. There is help for the same within
>>uboot itself (type help at uboot command prompt)
>>Or u can use the ost host tool as described in the oskfordummies.
>>
>>   =20
>>
>>>*(iii)Is there any terminal program(like minicom,hyperterminal) to
>>>     =20
>>>
>>upload
>>   =20
>>
>>>the executable file into the kernel for "tftp"?*.
>>>     =20
>>>
>>Ok.. I assume that u would like to download kernel? Or do u want to
>>download a filesystem? Let me try either one of them
>>Onboard, u can use the loadb command that can take a file
>>(uImage/uboot.bin/some bin) over serial port using Kermit. Once u have =
a
>>filesystem (either ramdisk/jffs2 based flash/nfs filesystem) u can boot
>>ur kernel. But a kernel alone will not be of much use to u. the apps
>>need to reside on the filesystem. Once u have the filesystem is
>>available and u have some sort of prompt, check the filesystem apps
>>available. They should behave as if you are on a normal linux box.
>>
>>Regards,
>>Nishanth Menon
>>
>>   =20
>>
>>-----------------------------------------------------------------------=
-
>>
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>   =20
>>
