From: <anupam.mahajan@wipro.com>
Subject: NFS Root File system and C File operation
Date: Fri, 4 May 2007 16:41:40 +0530
Message-ID: <E98CB0DA71F20341907598C3494F320D06CD75@BLR-EC-MBX08.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
=20
Subject - Not able to write into a file from an application running on =
Linux-OMAP2430 board.
=20
Set up Info-
-----------------
=20
Boot Parameters-
setenv bootargs console=3DttyS0,115200,n8 noinitrd =
ip=3Dxx.xx.xx.xx:yy.yy.yy.yy:255.255.255.0 root =3D/dev/nfs rw =
nfsroot=3DLinuxHostIP:/rootfs,nolock mem=3D128M
=20
=20
Linux Bring Up-
The Linux kernel on the Target(OMAP2430) boots from the NFS root file =
system (residing on LinuxHost at location
/rootfs ). Once Linux kernel is up on Target, root file system can be =
seen using "ls" command - bin, sbin, tmp, usr, etc ......... so on.
Now, there is an application which is started and tries to open a file =
in the /tmp/ directory.=20
The file is getting created from application, even write operation is =
also seems to be working from application point of view.=20
Since there are necessary conditions present in the application to check =
the operations. The applications ends with closing the file. =20
=20
Now, when checking  the file in /tmp diectory, the file created from the =
Application is present with 0 bytes. This means write operation didn't =
happen.
=20
I have tried the following -
1. In application, I have tried using open,write and close or  fopen, =
fputc, fclose =20
2. In Linux Host PC=20
 /etc/exports contains=20
/rootfs      *(rw,sync)
=20
Please suggest me!!!!!!
=20
=20
-Reagrds,
Anupam Mahajan
------------------------------------
=20
=20
=20
=20
=20
=20
