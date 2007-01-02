From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP MMC - problem with initing card
Date: Tue, 2 Jan 2007 11:47:06 -0800
Message-ID: <20070102194706.GD6695@atomide.com>
References: <200612232327.06035.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200612232327.06035.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061223 14:33]:
> Hi,
> I posted this question some time ago, but I made some progress.
> Here it is: I=C2=B4ve been using omap mmc driver (omap.c) on Palm Zire7=
1 since=20
> 2.6.16 at least and it was working perfectly. I was using the mmc card =
as=20
> root device. There was no problem with it - I booted linux, mmc got ini=
ted,=20
> printed info about partitions on it (that mmc0: p1 p2) and system norma=
lly=20
> booted from it. This changed by this merge
>=20
> http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dcomm=
it;h=3D36808520ce2c9ade647d36c80004c158c71d0510
>=20
> which caused, that the list of partition wasnt displayed anymore and sy=
stem=20
> ended up without root device. Like the mmc wasnt present at all. I test=
ed=20
> latest git and when I used initramfs and (from initramfs environment) i=
ssued
>=20
> mount /dev/mmcblk0p2 /mnt/card
> (mount second partition of mmc to /mnt/card)
>=20
> it made the kernel somehow init the card. So the list of partitions got=
=20
> printed (mmc0: p1 p2), but mount crashed and argued that it cant mount =
that=20
> partition. So I tried it once again... and voila, partition was mounted=
=20
> without problems and was working like before. But the problem still=20
> persists - I cant boot directly from it without initramfs. Any ideas?
>=20
> Thanx a lot for anything, any ideas.
> Enjoy tomorow ;-)

Just a guess, but it sounds like something is not ready with MMC when
compiled in. Maybe try rootdelay=3D3 or something to try to troubleshoot
it?

Tony
