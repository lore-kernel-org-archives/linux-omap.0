From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: 2420 H4 and kernel startup RAM error
Date: Tue, 10 Jan 2006 06:18:39 -0800 (PST)
Message-ID: <20060110141839.49109.qmail@web32903.mail.mud.yahoo.com>
References: <3d3153f60601100605p36bc331y971958e446e1d476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60601100605p36bc331y971958e446e1d476@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>, "Menon, Nishanth" <x0nishan@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Ola Helm <ola.hel@gmail.com> wrote:

> I got the RAMdisk setup working as adviced. Thanks to all for help.
>=20
> Then I tried the JFFS but again faced problems. I continue it here
> though
> the heading is not quite correct anymore..
=20
Hope this helps. You know from where to get flash_* tools.=20

----
1. Make JFFS2 Filesystem.

#mkfs.jffs2 -v --eraseblock=3D128KiB -l --root=3D$(ROOTFSDIR) -o
$(IMAGEDIR)/rd-jffs2.bin

2. Boot the Kernel with NFS Filesystem. {Flashing through mtd tools}

#cat /proc/partitions
major minor  #blocks  name

31     0        128 mtdblock0

31     1        128 mtdblock1

31     2       2048 mtdblock2

31     3      63232 mtdblock3

{erase through character device *not* block device}

{"-j" option will makes partition suitable for JFFS2 }

#flash_eraseall /dev/mtd/3 -j

{It will take time to erase the 60+ MB Flash }

#flashcp -v rd-jffs2.bin /dev/mtd/3

{It again erases the flash ..I don't know why and copies and
verifies the data at the end }

[Cross check the filesystem by mounting it offline]

#mount -t jffs2 /dev/mtdblock/3 /mnt/flash

[Flashing the Kernel in]

{erase 2MB partition for kernel }

#flash_eraseall /dev/mtd/2
#flashcp H4-kernel.cc /dev/mtd/2 -v

3. Booting the kernel and filesystem from Flash.

Change the kernel boot arguments like this:

On U-boot prompt:

#setenv bootargs console=3DttyS0,115200n8 root=3D/dev/mtdblock3
rootfstype=3Djffs2 rw     =20

#bootm 04040000

While booting you might see lots of messages starting with
CLEANMARKER..Please ignore them..as it is just a indication of empty
flash.=20
----=20


---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20
