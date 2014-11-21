From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix i207 errata handling
Date: Sat, 22 Nov 2014 02:16:53 +0300
Message-ID: <ED68D587-66C0-427A-85D5-D213DC136ECD@gmail.com>
References: <1416529011-21803-1-git-send-email-al.kochet@gmail.com> <089B5BDA-682D-46B6-869F-A6ADDFE691C3@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <089B5BDA-682D-46B6-869F-A6ADDFE691C3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


21 =CE=CF=D1=C2. 2014 =C7., =D7 3:29, Alexander Kochetkov <al.kochet@gm=
ail.com> =CE=C1=D0=C9=D3=C1=CC(=C1):

>>=20
>> Found by code review. Real impact haven't seen.
>> Tested on Beagleboard XM C.
>=20
> Does anybody know the "certain rare conditions" when RDR errata appea=
rs?
> I tested without luck (Beagleboard XM C).

Spent half a day trying to catch the errata without luck.
Tried to simulate noise on the bus in hope it may happen.
Tried to run with OMAP_I2C_FLAG_NO_FIFO flag.

What a mystery errata. Hiding.

Anyway, thanks!
Have a nice weekend!
