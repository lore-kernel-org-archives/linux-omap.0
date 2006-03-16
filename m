From: May Lin <foxfromworld@yahoo.com.tw>
Subject: How to make the module tools work on 2.6 kernel and ARM
Date: Thu, 16 Mar 2006 21:43:48 +0800 (CST)
Message-ID: <20060316134348.30216.qmail@web17505.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi...
I have upgraded my kernel to ver.2.6.
But when I want to make modules_install...
The following message shows up.

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
Warning: you may need to install module-init-tools
See
http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
  INSTALL drivers/ide/ide-core.ko
  INSTALL drivers/ide/ide-disk.ko
  INSTALL drivers/ide/legacy/ide-cs.ko
  INSTALL fs/fat/fat.ko
  INSTALL fs/msdos/msdos.ko
  INSTALL fs/nls/nls_base.ko
  INSTALL fs/nls/nls_cp437.ko
  INSTALL fs/nls/nls_iso8859-1.ko
  INSTALL fs/vfat/vfat.ko
  INSTALL net/packet/af_packet.ko
if [ -r System.map -a -x /sbin/depmod ]; then
/sbin/depmod -ae -F System.map  2.6.12-omap1; fi
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/drivers/ide/ide-core.ko
not for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/drivers/ide/ide-disk.ko
not for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/drivers/ide/legacy/ide-cs.ko
n
ot for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/fat/fat.ko not for
this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/msdos/msdos.ko not
for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/nls/nls_base.ko
not for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/nls/nls_cp437.ko
not for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/nls/nls_iso8859-1.ko
not for this architecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/fs/vfat/vfat.ko not
for this a
rchitecture
depmod: ELF file
/lib/modules/2.6.12-omap1/kernel/net/packet/af_packet.ko
not for this architecture
make: *** [_modinst_post] Error 1

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<,<<<




Do you know how to solve it??

___________________________________________________  =B3=CC=B7s=AA=A9 Yah=
oo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=B8=F4=B9q=B8=DC=A5=F4=
=A7A=A5=B4=A1I  http://messenger.yahoo.com.tw/
