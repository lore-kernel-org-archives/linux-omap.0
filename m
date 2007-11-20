From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP 5912: new kernel, how to create a new file system?
Date: Tue, 20 Nov 2007 12:24:27 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302A4C012@dlee12.ent.ti.com>
References: <6a7f58da0711200959u1481a90y5b50e9a5c5827c82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <6a7f58da0711200959u1481a90y5b50e9a5c5827c82@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mik Prog <mikprog@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Dear all,
>=20
> I am an absolute beginner with OMAP and Linux (I am working=20
> on a OSK 5912).
> Apologies if some of my questions have already been answered. I do
> look on google first, but sometime even if the topic has been treated
> I don't clearly understand...
>=20
> Here my case:
> 1. I wanted recompile the kernel image using arm-linux-gcc 3.4.1 (I
> got the kernel sources 2.6.20 and applied the patch
> patch-2.6.20-omap1)
> 2. then I enabled on omap_osk-5912_defconf the USB configuration
> 3. I built the kernel and formatted for u-boot.
> 4. I transferred that to OMAP using tftpboot
> 5. $ using uname -a I see that the kernel image is still the old one!
>=20
> Do I need to update the root file system as well?
> How could I create my own root file system based on the kernel version
> I've compiled?

Sounds like either the new image was not correctly copied to /tftpboot
or after you did the tftp download you booted the old image (maybe in
flash) and not the new one (in RAM). When you download the image to RAM,
afterwards execute:

# bootm <load-addr>

For example if the image is loaded to RAM address 0x80000000. Then
execute:

# bootm 0x80000000

Please note the above does not give me much to go on. So if this is not
the problem provide more details of the exact commands you are
executing.=20

With regard to a new root filesystem see the following document, should
get you going:
http://www.capgo.com/Resources/SoftwareDev/osk-newbie-guide.pdf

For more resources check out Tony's OMAP page:
http://www.muru.com/linux/omap/=20

Cheers
Jon
