From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: OMAP MMC - problem with initing card
Date: Sat, 23 Dec 2006 23:27:05 +0100
Message-ID: <200612232327.06035.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I posted this question some time ago, but I made some progress.
Here it is: I=B4ve been using omap mmc driver (omap.c) on Palm Zire71 since=
=20
2.6.16 at least and it was working perfectly. I was using the mmc card as=20
root device. There was no problem with it - I booted linux, mmc got inited,=
=20
printed info about partitions on it (that mmc0: p1 p2) and system normally=
=20
booted from it. This changed by this merge

http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcommit;h=
=3D36808520ce2c9ade647d36c80004c158c71d0510

which caused, that the list of partition wasnt displayed anymore and system=
=20
ended up without root device. Like the mmc wasnt present at all. I tested=20
latest git and when I used initramfs and (from initramfs environment) issued

mount /dev/mmcblk0p2 /mnt/card
(mount second partition of mmc to /mnt/card)

it made the kernel somehow init the card. So the list of partitions got=20
printed (mmc0: p1 p2), but mount crashed and argued that it cant mount that=
=20
partition. So I tried it once again... and voila, partition was mounted=20
without problems and was working like before. But the problem still=20
persists - I cant boot directly from it without initramfs. Any ideas?

Thanx a lot for anything, any ideas.
Enjoy tomorow ;-)

Best regards
Marek
