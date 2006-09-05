From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: problem booting my file system image
Date: Mon, 4 Sep 2006 23:18:07 -0300
Message-ID: <ae36f8040609041918k2b2fc97dw22d9a7c10e9f0cb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi i trying to boot my own filesystem, but i receiving the following:
omap_rtc omap_rtc: setting the system clock to 2000-01-01 00:00:00 (9466848=
00)
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0xf062 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
0xc79c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008:
0x8e1f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
0xbe53 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000010:
0x373a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000014:
0x4dd8 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018:
0x8b2c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
0xdf77 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
0x88a7 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024:
0xfc15 instead
Further such events for this erase block will not be printed
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 116K
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init=3D option to k=
ernel.

How to fix this ???

OMAP5912 OSK # printenv
bootdelay=3D3
baudrate=3D115200
bootfile=3D"uImage"
ethaddr=3D00:0E:99:02:0A:4D
bootargs=3Dmem=3D32M console=3DttyS0,115200n8 noinitrd rw
root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount
netmask=3D255.255.255.0
ipaddr=3D10.30.46.250
serverip=3D10.30.46.47
bootcmd=3Dcp.b 0x00100000 0x10000000 0x00145a24;bootm
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

please any advice about create an filesystem based on busy box is welcome.
--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
