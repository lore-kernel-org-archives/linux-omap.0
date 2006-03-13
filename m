From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: Which patches for 2.6.15 for 5912OSK?
Date: Mon, 13 Mar 2006 10:44:59 -0000
Message-ID: <003601c6468b$2d1dbd40$642aa8c0@BUFFY>
References: <001101c644ea$26a680c0$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001101c644ea$26a680c0$0301a8c0@hydra>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?'Micha=B3_Szabat'?= <michal611@interia.pl>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Michal,

Thanks for the information. I only had to copy two files from plat-omap =
to
mach-omap1: pm.c and sleep.S

I have a running kernel. Now I just need to configure the dsp gateway. =
Do
you have any information on how to do that?

Thanks again,

Richard.

-----Original Message-----
From: Micha=B3 Szabat [mailto:michal611@interia.pl]=20
Sent: 11 March 2006 09:00
To: Richard Copeman
Subject: Re: Which patches for 2.6.15 for 5912OSK?

hello.
I compiled kernel 2.6.15 with patch-2.6.15-omap1. This patch contains =
source

for dspgateway comunications. I used toolchain 3.4.1 and must copied =
some=20
files from /usr/src/linux-2.6.12/arch/arm/mach-omap  to=20
/usr/src/linux-2.6.15/arch/arm/mach-omap1.=20


---------------------------------------------------------------------
Toshiba i FIFA World Cup
Wygraj bilety i notebooki z Intel Centrino Duo Mobile Technology
http://link.interia.pl/f1912
