From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: omap: implement workaround for handling invalid BB-bit values
Date: Sun, 23 Nov 2014 16:18:40 +0300
Message-ID: <1CC68911-DF20-4FF0-A08A-1A6F0B565662@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com> <1416518925-20679-3-git-send-email-al.kochet@gmail.com> <20141121160808.GM7508@saruman> <20141122132309.GC2679@katana> <B6D9B4D7-25CB-456F-88B4-EB6A53E33A9D@gmail.com> <20141122180222.GA9698@katana> <20141123044306.GA19898@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141123044306.GA19898@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


23 =CE=CF=D1=C2. 2014 =C7., =D7 7:43, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> =CE=C1=
=D0=C9=D3=C1=CC(=C1):

> maybe there was a typo? I tested on v3.18-rc3 :-)

I do my tests on kernel from angstrom with almost all i2c-omap patches =
backported from linux/master.
Then I rebased them to wrong (old) kernel version and posted to the lis=
t.

Angstrom kernel is from meta-ti layer. It's the same kernel as for arag=
o.
http://arago-project.org/wiki/index.php/Main_Page

I would really like to switch to the recent kernel, but I don't know ho=
w good codec engine (CE) is supported on it.
Initially all ti drivers for codec engine was done for 2.6.x kernels an=
d later some of them was ported for 3.2.x.

=46elipe, do you know how CE is supported on v3.18-rc3?

Regards,
Alexander.
