From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: booting new image
Date: Sun, 24 Sep 2006 09:52:46 -0500
Message-ID: <45169BBE.70700@gmail.com>
References: <ae36f8040609212108t1af9f0d5qc82f6eb5d717f546@mail.gmail.com>	<45140C14.9020508@balister.org>	<ae36f8040609221022y6f0a0802i56d849a45d27b994@mail.gmail.com>	<4514202A.6050207@balister.org>
	<ae36f8040609221114v585d557ax7e491d1b84e165da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040609221114v585d557ax7e491d1b84e165da@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Vit=F3rio Cargnini stated on 9/22/2006 1:14 PM:
> Gentlemen after booted my board using the image available in:
> http://oskfordummies.hp.infoseek.co.jp/downloads/rootfs2.6.11_0612.tar.=
bz2
>=20
> it booted using my kernel and my u-boot, it's an busybox version 1.0.0 =
so i
> think the problem colud be with busy box.
> any opinion ?
yes, like OE, udev here too? that is a usual tricky place too.. I just
googled and saw some stuff like this:
http://bugs.busybox.net/view.php?id=3D1041
I suppose you can move to 1.2.1. give that too a shot :) or maybe ping
the buxybox folks on this. http://www.busybox.net/lists.html

Regards,
Nishanth Menon
