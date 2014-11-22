From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: omap: implement workaround for handling invalid BB-bit values
Date: Sat, 22 Nov 2014 17:06:10 +0300
Message-ID: <B6D9B4D7-25CB-456F-88B4-EB6A53E33A9D@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com> <1416518925-20679-3-git-send-email-al.kochet@gmail.com> <20141121160808.GM7508@saruman> <20141122132309.GC2679@katana>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141122132309.GC2679@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


22 =CE=CF=D1=C2. 2014 =C7., =D7 16:23, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>=
 =CE=C1=D0=C9=D3=C1=CC(=C1):

> Huh, I can't apply this one? Which kernel version is this based on?

v.3.13-rc8
It depends on PATCH 1/4

alexander@ubuntu:git.kernel.org.pub.scm.linux.kernel.git.stable.linux-s=
table$ git log --pretty=3Doneline --abbrev-commit -6
204c058 i2c: omap: add notes related to i2c multimaster mode
2b15417 i2c: omap: don't reset controller if Arbitration Lost detected
38ef30e i2c: omap: implement workaround for handling invalid BB-bit val=
ues
9b15135 i2c: omap: cleanup register definitions
a7483d8 Fixes: 1d7afc9 i2c: omap: ack IRQ in parts
7e22e91 Linux 3.13-rc8
