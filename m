From: Ola Helm <ola.hel@gmail.com>
Subject: Re: 2420 H4 and kernel startup RAM error
Date: Wed, 11 Jan 2006 12:46:31 +0200
Message-ID: <3d3153f60601110246y3dd5e8e2vccbbbdd04aa08875@mail.gmail.com>
References: <520AB2AD990DC04082102F77CA1726380236AE15@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726380236AE15@dlee03.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>, Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks again for advices.

1. booting a kernel from flash


I'd say this one works. I have managed to copy the kernel to flash and boot
it up from 0x04040000, and it works nicely with ramdisk image. The ramdisk
is naturally vanished after restart, but kernel stays. So the task is to
make it work as well with jffs


2. Using a jffs2 partition


Both filesystem in tarball and mkfs require having the file there already,
am I right. There is no copying or loading from anywhere so seems to me tha=
t
it is expected to have FileSystem.tgz there already while starting kernel.

tar -xvzf ../FileSystem.tgz



 Same seems to apply with mkfs .I.e. You'd load the jffs filesystem image
with current filesystem, like NFS.

The questions are:
1) No way to do filesystem flashing and loading in uboot state i.e. with
same method as with kernel?
2) Is there a way to load the image afterwards i.e. when the system has
booted up with some filesystem?
3) Could this kind loading be done with ramdisk system?

I must try playing with mtd-tools at the meanwhile..

/O
