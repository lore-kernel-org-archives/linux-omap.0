From: <adapa.ajith@wipro.com>
Subject: Regarding NAND booting in OMAP 2430 board
Date: Mon, 31 Dec 2007 11:09:07 +0530
Message-ID: <998B37C19BFDB549AA703C78A86EAA19DC5457@blr-m1-msg.wipro.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

=20

I am trying to boot Kernel from NAND using X-Loader.

=20

These are the steps I followed .....

=20

1.	Built x-load.bin and coverted it to x-load.raw and signed it
using CSST tool resulting x-load.raw.ift.

=20

2.	Then OMAP 2430 board is set to USB NAND pin settings and loaded
the x-load.raw.ift to NAND at memory location 0xC000000 using CSST tool.


=20

3.	Built u-boot.bin which supports both NAND and ONENAND as its
subsystem (My u-Boot version is 1.1.4).

=20

4.	Then OMAP 2430 board is set to USB NOR pin settings and
u-boot.bin is loaded to NOR at memory location 0x4000000 using CSST
tool.

=20

5.	Now OMAP is set to "NOR Flash booting  and NAND Chip enable pin
settings" and connected via hyperterminal which boots in NOR. (I am not
sure about these pin settings .......... Are there any such pin settings
.... If so I like to have the document which contains these pin
settings.)

=20

6.	Now using TFTP copied u-boot.bin i.e tftp 0x80000000 u-boot.bin

=20

7.	Nand Flash is erased and then U-boot image is written into nand
flash.

=20

8.	Then when I try to power on the board  to be able to boot in
NAND the board is simply getting STUCK and FREZED ...........=20

=20

I like to know any bugs or errors in my steps .... Or an appropriate
document which can make me successfully boot me from NAND.

=20

=20

Thanks and Regards,
A. AJITH

http://codingfreak.blogspot.com/

=20

"Do your best,God will do the rest"

=20
