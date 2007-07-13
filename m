From: <simonchu47@yahoo.com.tw>
Subject: Re: Cannot ping localhost
Date: Fri, 13 Jul 2007 13:36:56 +0800 (CST)
Message-ID: <353498.32418.qm@web72711.mail.tp2.yahoo.com>
References: <46970715.5070904@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46970715.5070904@css-design.us>
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

Yes, I can, as following:
# ping -c 3 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=3D0 ttl=3D64 time=3D0.8 ms
64 bytes from 127.0.0.1: seq=3D1 ttl=3D64 time=3D0.4 ms
64 bytes from 127.0.0.1: seq=3D2 ttl=3D64 time=3D0.4 ms

--- 127.0.0.1 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet
loss
round-trip min/avg/max =3D 0.4/0.5/0.8 ms

My root file system is on the ROM 0x1000000

--- Steve Poulsen <spoulsen@css-design.us> =BB=A1=A1G

> Can you ping 127.0.0.1?
>=20
> Where is your root file system? Do you have any
> thing working via Ethernet?
>=20
> Steve Poulsen
>=20
>=20
> simonchu47@yahoo.com.tw wrote:
> > Hi:
> > I am using an OMAP5912 OSK board, and I have build
> a
> > kernal image and root file system running in it.
> > After booting up, I found that I cannot ping
> > localhost, but my application needs to chect it.
> > The error is as following:
> >
> > # ping localhost
> > ping: bad address 'localhost'
> >
> > my U-Boot is 1.1.5, Linux kernel version
> 2.6.12-omap1,
> > and BusyBox v1.5.0. I have added /etc/hosts and
> > /etc/host.conf
> >
> > # cat /etc/hosts
> > # Do not remove the following line, or various
> > programs
> > # that require network functionality will fail.
> > 127.0.0.1               localhost.localdomain
> > localhost
> >
> > But it doesn't work. Can anybody tell me why?
> >
> >
> >     =20
>
_________________________________________________________________________=
___________
> > =B7Q=A4=CE=AE=C9=B3q=AA=BE=B3q=B0T=BF=FD=B8=CC=AA=BA=A9=D2=A6=B3=BF=CB=
=AAB=A6n=A4=CD=A6n=AE=F8=AE=A7=A1A=B4N=A8=D3
> Yahoo!=A9_=BC=AF=B9q=A4l=ABH=BDc=B5o=C2=B2=B0T=A1I
> > http://tw.mobile.yahoo.com/texts/mail.php
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> >  =20
>=20
>=20



      ___________________________________________________________________=
_________________
=B3]=A9w=A6w=A5=FE=B9=CF=B3=B9=A1A=ABO=C5@=B1z=AA=BA Yahoo!=A9_=BC=AF=B1b=
=B8=B9=A4=A3=B3Q=C0b=AB=C8=B5s=A5=CE=A1I
http://tw.info.yahoo.com/seal/index.html
