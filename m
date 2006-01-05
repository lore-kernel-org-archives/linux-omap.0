From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: 2420 H4 and kernel startup RAM error
Date: Thu, 5 Jan 2006 07:28:42 -0600
Message-ID: <99E943D7AA8E3A448619E1F809F2A2A201160D7F@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

rd-jffs2 is not a ramdisk.  It is a flash file system that you write to
flash.  I have not looked lately, but a ramdisk would be named something
like rd-ext2.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com]=

On Behalf Of Ola Helm
Sent: Thursday, January 05, 2006 7:12 AM
To: linux-omap-open-source@linux.omap.com
Subject: Re: 2420 H4 and kernel startup RAM error

I have to load RAM-image and try it, so actually I haven't told kernel
to
load RAM-image from anywhere yet. I assume the RAMDISK image is
following
one, right?

rd-jffs2.

In case serial connection is used, what might be the erase/protect
addresses
then? And what would be the procedure of loading the images? I.e. in
case of
tftp it seems to be that you give addresses while loading the image and
thus
can load images one after another. But how about in case serial loading,
should I copy kernel image first to some address, then load RAM-image
and
copy it then to some address (0x80600000 perhaps?).

At the moment purpose is simply to load kernel so that it can be used.

Thanks for quick answers!

/O

On 1/5/06, Menon, Nishanth <x0nishan@ti.com> wrote:
>
>
> > I have tried both to erase 0x4000000 0x417FFFF and load with file
size
> > 0x1222e0, source address 0x80000000 and destination address
0x4040000
> i.e
> >
> > cp.b 0x80000000 0x4040000 1222e0
> >
> > Kernel command line: root=3D/dev/ram0 rw mem=3D32M
console=3DttyS0,115200n8
> > initrd=3D0x80600000,8M ramdisk_size=3D8192
> I guess u told the kernel to load a ramdisk from
0x80600000(initrd=3Dxyz)
> and the ramdisk image remained in flash...
> If U'd like the file system in flash(and use it from flash) 0x04040000
> then it should be a jffs2 filesystem.
> Regards,
> Nishanth Menon
>
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
