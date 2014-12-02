From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: omap: fix buffer overruns during RX/TX data processing
Date: Tue, 2 Dec 2014 14:17:13 +0300
Message-ID: <B3F4FEFF-2333-473D-8A35-7D4EF1C44D90@gmail.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com> <1417294803-14729-2-git-send-email-al.kochet@gmail.com> <20141201195841.GD2817@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141201195841.GD2817-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


01 =C4=C5=CB. 2014 =C7., =D7 22:58, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> =CE=
=C1=D0=C9=D3=C1=CC(=C1):

> I think this is a different issue than what I'm seeing.

Hello, Tony!

Thank you for testing!

Could check i2c-omap.c from commit ca1f8da9ac5ce6e63d8f6933f83fabc1f3f9=
61f4.
As all my changes comes after it[1]. So I can understand was the proble=
m before my work.

I there was no problems, then try with my first commit:
27caca9d2e01c92b26d0690f065aad093fea01c7

The problems you talk about is this?
[    9.675994] omap_i2c 48072000.i2c: controller timed out
[   10.704010] omap_i2c 48072000.i2c: controller timed out
[   11.734069] omap_i2c 48072000.i2c: controller timed out
root@omap2430sdp:/# [   12.823638] omap_i2c 48072000.i2c: controller ti=
med out

And how it is possible to switch from ti,omap2430-i2c to ti,omap2420-i2=
c? They are so different IP, from
the driver point of view. They have different data bus width.

Alexander.

[1]
alexander@ubuntu:busses$ git log --pretty=3Doneline --reverse ca1f8da9a=
c5ce6e63d8f6933f83fabc1f3f961f4^..HEAD -- i2c-omap.c=20
ca1f8da9ac5ce6e63d8f6933f83fabc1f3f961f4 i2c: remove FSF address
27caca9d2e01c92b26d0690f065aad093fea01c7 i2c: omap: fix NACK and Arbitr=
ation Lost irq handling
854a59425a0b9600ee974b113aae081c873163f6 i2c: omap: cleanup register de=
finitions
903c3859f77f9b0aace551da03267ef7a211dbc4 i2c: omap: implement workaroun=
d for handling invalid BB-bit values
80cc361f14e8fa97119afa3324c2c913915e7252 i2c: omap: don't reset control=
ler if Arbitration Lost detected
39370ab406933efdedb425910f0a36c16667c45f i2c: omap: add notes related t=
o i2c multimaster mode
ccfc866356674cb3a61829d239c685af6e85f197 i2c: omap: fix i207 errata han=
dling
7d168dc7ed384e50bb7bff4920b73550fd2e9fcb Merge branch 'i2c/for-3.19' in=
to i2c/for-next
2f769d173f0e6a2e85d75fe396f18f794fc4a615 omap: i2c: don't check bus sta=
te IP rev3.3 and earlier
2b6f66d87b44aaf1f34f071e6f6430c3ccaa8812 i2c: omap: fix buffer overruns=
 during RX/TX data processing
30c52545106785405856c7e7e40b683b79c8084a i2c: omap: show that the reaso=
n of system lockup is an unhandled ISR event
