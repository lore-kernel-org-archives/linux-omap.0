From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: choice of bootloader on omap 1510
Date: Mon, 10 Apr 2006 10:29:39 -0500
Message-ID: <C51F43ABFC95844490F0529B60753BF4043FE320@dlee02.ent.ti.com>
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
To: Kavita Kalra <kavita.dsp@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I am on the initial stage of loading linux on omap 1510. Want to know
> whether rrlaod or
> uboot should be used as a bootloader. Also from where can i obtain the
> bootloader and kernel image.Is there any document available for
beginners
> ....
>=20
> uboot is a universal bootloader....does it mean that the uboot 1.1.1
image
> which i have for omap 5912...(was thr in the cd along with the kit of
omap
> 5912) can also be used for oamp1510.
>=20
=20

You should be able to use either rrload or uboot for the omap1510
innovator. The rrload bootloader was the original bootloader used for
the innovator, however, I believe that rrload is no longer being
maintained. Rigderun developed this bootloader, but I am not sure that
they are still in business. Plus I am not sure where you can get the
source to this bootloader from. However, if it does what you need then,
I don't see why you could not use this.=20

The uboot bootloader succeeded rrload and is now the preferred
bootloader for all omap platforms. Hence, if you are looking for one
booloader that could be used on the omap1510, 5912, etc, then uboot is a
better bet. Plus you will find a lot more support for uboot on the web
too. The source for uboot can be downloaded from the following sites:

ftp://ftp.denx.de/pub/u-boot/
http://www.sourceforge.net/projects/uboot

More info on uboot here:
http://www.denx.de/wiki/view/DULG/UBoot

Jon=20
