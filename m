From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: booting process
Date: Wed, 31 May 2006 16:27:22 -0300
Message-ID: <ae36f8040605311227k61f7d225s511b180b5b22cfec@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi i compiled my u-Boot based on git tree, put omn the OSK 5912 board,
compiled my Kernel based on git tree, loaded to the board too.
Now some thisng remain i need to boot it, whe i did "tftp 00100000 uImage" =
i
download and put uImage there then bootm works, but if after i try to uploa=
d
my jffs image nothing works.
How to fix this ?
How to boot automatically ?
my mkfs.jffs2 command: mkfs.jffs2 -U -d filesys/ -o system.jffs2.img
my bootargs: bootargs=3Dmem=3D32M console=3DttyS0,115200n8 noinitrd rw
root=3D/dev/mtdblock4 rootfstype=3Djffs2




the error after reloaded the kernel and did bootm
Skipping reset check for DSP domain clock "dspper_ck"
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
No filesystem could mount root, tried:  jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)



is write protected the flash ?


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
