From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: OMAP H4 Boot from MMC Card
Date: Tue, 31 Oct 2006 19:30:39 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01C1A0EF@DLEE09.ent.ti.com>
References: <1162342628.2816.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <1162342628.2816.19.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hkh@cypress.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Format the MMC card to EXT2 FS.=20
Copy your existing NFS target file system MMC partition.
(You can do this on any standard Linux PC with card reader or use the
board itself)

Modify the bootargs to=20
setenv bootargs console=3DttyS0,115200n8 noinitrd root=3D/dev/mmcblk0p1 =
rw
ip=3Doff devfs=3Dmount

Note: You might have to change the /dev/mmcblk0p1 to what ever you are
getting for MMC dev on your board.

Regards,
Khasim
-----Original Message-----
From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]
On Behalf Of Hingkwan Huen
Sent: Tuesday, October 31, 2006 6:57 PM
To: linux-omap-open-source@linux.omap.com
Subject: OMAP H4 Boot from MMC Card

Dear All,

I am currently running 2.6.17 and OPIE on the OMAP2420 H4 with rootfs
via NFS. In order to make the whole setup more portable and not
depending on the network, I would like to have the rootfs on the MMC
card. Could anyone help provide an instruction how to set this up,
please?

Thanks,
kwan

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
