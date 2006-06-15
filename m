From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: MMC problem OMAP
Date: Thu, 15 Jun 2006 16:01:23 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C0936DC@edpc500.cedt.iisc.ernet.in>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All

=20

I am trying to mount MMC/SD file system in OMAP 1510 (TI Innovator).  I
have enabled SD support and ext2 support in the kernel
(2.6.16.13-omap1).  When the kernel boots up the following messages are
coming.=20

=20

1)       Anyone got the same error?  What is the source of the error?

2)       Anyone mounted a ext2 file system from MMC/SD?  How do I go
about doing this?

=20

Thanks in advance

Prakash

=20

MUX: initialized MMC_DAT1

MUX: initialized MMC_DAT2

MUX: initialized MMC_DAT3

MMC1: Command timeout, CMD0

MMC1: Command timeout, CMD0

MMC1: Command timeout, CMD7

mmcblk0: mmc0:a95c SD016 14400KiB

 mmcblk0:<7>MMC1: Data CRC error, bytes left 0

mmcblk0: error 2 transferring data

end_request: I/O error, dev mmcblk0, sector 0

Buffer I/O error on device mmcblk0, logical block 0

mmcblk0: error 2 transferring data

end_request: I/O error, dev mmcblk0, sector 0

Buffer I/O error on device mmcblk0, logical block 0

 unable to read partition table
