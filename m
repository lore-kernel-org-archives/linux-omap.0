From: <simonchu47@yahoo.com.tw>
Subject: Re: Cannot ping localhost
Date: Tue, 17 Jul 2007 14:53:36 +0800 (CST)
Message-ID: <201231.39280.qm@web72702.mail.tp2.yahoo.com>
References: <Pine.LNX.4.64.0707131322340.2465@titan.hyper.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0707131322340.2465@titan.hyper.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ari Saastamoinen <arzka@gamedude.fi>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org




> On Fri, 13 Jul 2007, simonchu47@yahoo.com.tw wrote:
>=20
> > # ping localhost
> > ping: bad address 'localhost'
>=20
> > 127.0.0.1               localhost.localdomain
> > localhost
>=20
> Is that really TWO lines? Or did email program add
> that newline?

No, it's the same line.
>=20
> > But it doesn't work. Can anybody tell me why?
>=20
> If I remember correctly there is an option to use
> builtin hostname=20
> resolver in busybox. Are you using it or are you
> using resolver offered by=20
> libc? What libc version you are using? If glibc, are

I have tried dnsd of busybox. Do you mean that? I have
never found "nameresolver" option of busybox while
execuating "make menuconfig".


> you using dynamic or=20
> static nss libraries? If dynamic, do you have
> libnss_files installed? Is=20
> the nsswitch.conf configured correctly?

I have tried to build a test program using
"getaddrinfo"function, which should be called from
glibc. And I printout the return value of the
function. The following is the result:
=20
OMAP5912OSK
-2
getaddrinfo() failed: Name or service not known

PS:OMAP5912OSK is the hostname.

My cross compiler is arm-linux-gcc, and the version is
3.3.2. Can anyone tell me how to solve the problem?


>=20
> --=20
> Arzka
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20



      ___________________________________________________________________=
_________________
=A7=F9=B5=B4=BA=F4=B8=F4=C0b=AB=C8=A1A=ABO=BB=D9=B1b=B8=B9=A6w=A5=FE - =B0=
=A8=A4W=B3]=A9w Yahoo!=A9_=BC=AF=A6w=A5=FE=B9=CF=B3=B9http://tw.info.yaho=
o.com/seal/index.html
