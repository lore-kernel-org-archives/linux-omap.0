From: "Juergen Sievers" <JSievers@NADINE-Software.com>
Subject: AW: Help: OMAP5912 RS232 dies after kernel uncompressing.
Date: Mon, 15 Jan 2007 21:50:22 +0100
Message-ID: <001201c738e6$c7945890$0700a8c0@NADHHLT01>
References: <BAY102-F369B3C89BF75F87EB6E11DA9B50@phx.gbl>
Reply-To: JSievers@NADINE-Software.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <BAY102-F369B3C89BF75F87EB6E11DA9B50@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Abot Botbot' <dejanigma@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Andy.


Hem unbelievable.

But the omap mounts its nfs-root and I can login on the omap by using =
telnet

So I can not understand how a wrong configured nfs-server might stop the
ttyS0=20

Could it be that you did not read that the system boots completely or do =
I
not understand what you mean?

Mfg.
j.


-----Urspr=FCngliche Nachricht-----
Von: Abot Botbot [mailto:dejanigma@hotmail.com]=20
Gesendet: Montag, 15. Januar 2007 16:53
An: JSievers@nadine-software.com; linux-omap-open-source@linux.omap.com
Betreff: RE: Help: OMAP5912 RS232 dies after kernel uncompressing.

Juergen,

  Perhaps your NFS Share isn't set up correctly? I had that problem =
before I

had set up my NFS share with the right perms and whatnot. Maybe look =
into=20
the particulars of the config file and make sure all is well. Try =
mounting=20
the target NFS with another machine other than the board.

Hope this helps,
Andy

>From: "Juergen Sievers" <JSievers@nadine-software.com>
>Reply-To: JSievers@nadine-software.com
>To: "'Linux OMAP List'" <linux-omap-open-source@linux.omap.com>
>Subject: Help: OMAP5912 RS232 dies after kernel uncompressing.
>Date: Mon, 15 Jan 2007 16:22:26 +0100
>
>
>Hello.
>
>After I modified the environment by using setenv/saveenv I got the=20
>following
>problem.
>
>The terminal connected to the OMAP5912 rs232 at 115200n8 is working as =
long
>as the kernel is uploaded and decompressing. The last message shown is
>".booting."
>
>After that message the rs232 line seems to be dead.
>
>The kernel is mounting its root from nfs-server and is running normally
>except the console device could be used.
>
>I tried several kernels (2.6.16/2.6.19) including the pre-build kernel =
2.4
>from the distribution CD All the same, the rs232 line dies after
>uncompressing the kernel.
>
>My bootags setting are:
>
>Bootargs =3D "mem=3D32 console=3DttyS0,115200n8 ip=3Ddhcp =
root=3D/dev/nfs rw
>nfsroot=3D192.168.0.50:/nfsroot"
>
>Has anybody an idea what I could do to get back my rs232 console ?
>
>Regards
>
>Juergen
>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Find sales, coupons, and free shipping, all in one place! =A0MSN =
Shopping=20
Sales & Deals=20
http://shopping.msn.com/content/shp/?ctid=3D198,ptnrid=3D176,ptnrdata=3D2=
00639
