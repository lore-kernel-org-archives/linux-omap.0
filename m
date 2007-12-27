From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Issue With MMC driver for 2430
Date: Thu, 27 Dec 2007 10:36:34 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0014BDB7C@dbde01.ent.ti.com>
References: <dfeb90390712260439y7d8f7393w530c732fa48a56c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <dfeb90390712260439y7d8f7393w530c732fa48a56c6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Arun KS <getarunks@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Arun KS
> Sent: Wednesday, December 26, 2007 6:09 PM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: Linux-omap-open-source@linux.omap.com
> Subject: Issue With MMC driver for 2430
>=20
> Dear Madhu,
>=20
> I am using OMAP-2430 based custom board. I am facing some issue with =
MMC
> card detection. When I use NFS as file system my card is getting =
detected.
> I
> have a requirement of using ramdisk as the filesystem, which is of =
size
> 20MB.
> When I use 20MB ramdisk as the filesystem, the MMC card is not getting
> detected.
>=20

I think your filesystem on which MMC is not getting mounted does not =
support udev.

You can confirm by doing a ls -l /dev/mmcblkp1, for testing have a card =
in the slot and boot the kernel.

Regards,
Khasim
