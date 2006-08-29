From: kabbin <kabbin26@yahoo.com.tw>
Subject: RE: Building kenel error (uImage)
Date: Tue, 29 Aug 2006 18:43:07 +0800 (CST)
Message-ID: <20060829104307.77524.qmail@web17808.mail.tpe.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear all
   I use arm-linux-gcc 3.4.1 to build kernel 2.6.10 for omap2420h4
 (http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap24=
30.tgz)
  with =20
# make clean
# make omap_h4_2420_defconfig
# make uImage
And I got=20

  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  UIMAGE  arch/arm/boot/uImage
  "mkimage" command not found - U-Boot images will not be built
  Image arch/arm/boot/uImage is ready

I already got Image and zImage,=20

but I cannot find uImage in the directory (or any others) !=20

It seems that zImage and Image do not work on the target board.
How can I get uImage ?
Why "mkimage" command not found?
Could you tell me any suggestion? Thank you.=20
Best regards.           =20

___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
